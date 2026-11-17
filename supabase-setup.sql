-- Ejecutar una vez en Supabase > SQL Editor
create table if not exists public.estado (
  user_id uuid primary key references auth.users(id) on delete cascade,
  json text not null,
  updated_at timestamptz not null default now()
);
alter table public.estado enable row level security;
create policy "estado_select_propio" on public.estado for select using (auth.uid() = user_id);
create policy "estado_insert_propio" on public.estado for insert with check (auth.uid() = user_id);
create policy "estado_update_propio" on public.estado for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
