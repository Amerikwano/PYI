-- PYI private cloud sync. Run in Supabase SQL Editor.
create table if not exists public.pyi_entries (
  user_id uuid not null references auth.users(id) on delete cascade,
  entry_date date not null,
  content jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, entry_date)
);
alter table public.pyi_entries enable row level security;
create policy "Users can read own PYI entries" on public.pyi_entries for select using (auth.uid() = user_id);
create policy "Users can insert own PYI entries" on public.pyi_entries for insert with check (auth.uid() = user_id);
create policy "Users can update own PYI entries" on public.pyi_entries for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can delete own PYI entries" on public.pyi_entries for delete using (auth.uid() = user_id);
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('pyi-photos', 'pyi-photos', false, 5242880, array['image/jpeg','image/png','image/webp','image/heic'])
on conflict (id) do nothing;
create policy "PYI users can upload own photos" on storage.objects for insert to authenticated with check (bucket_id = 'pyi-photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "PYI users can view own photos" on storage.objects for select to authenticated using (bucket_id = 'pyi-photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "PYI users can delete own photos" on storage.objects for delete to authenticated using (bucket_id = 'pyi-photos' and (storage.foldername(name))[1] = auth.uid()::text);
