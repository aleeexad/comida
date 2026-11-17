-- Ejecutar una vez en Supabase > SQL Editor
-- Datos compartidos del hogar: solo estos dos correos pueden leer y escribir.
create table if not exists public.hogar (
  id text primary key,
  json text not null,
  updated_at timestamptz not null default now()
);
alter table public.hogar enable row level security;

create policy "hogar_select" on public.hogar for select to authenticated
  using ((auth.jwt() ->> 'email') in ('alejandro.comida@example.com','fernanda.comida@example.com'));
create policy "hogar_insert" on public.hogar for insert to authenticated
  with check ((auth.jwt() ->> 'email') in ('alejandro.comida@example.com','fernanda.comida@example.com'));
create policy "hogar_update" on public.hogar for update to authenticated
  using ((auth.jwt() ->> 'email') in ('alejandro.comida@example.com','fernanda.comida@example.com'))
  with check ((auth.jwt() ->> 'email') in ('alejandro.comida@example.com','fernanda.comida@example.com'));

-- (La tabla "estado" de la versión anterior ya no se usa para guardar; solo se lee una vez para migrar datos.)
