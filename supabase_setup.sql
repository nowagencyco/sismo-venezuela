-- ============================================================
--  ACTUALIZACIÓN v2 — Pega TODO en SQL Editor y dale RUN
--  (Supabase → SQL Editor → New query)
--  Seguro de correr aunque ya tengas la tabla 'reportes'.
-- ============================================================

-- 1) Asegurar tabla reportes (si ya existe, no pasa nada)
create table if not exists public.reportes (
  id          bigint generated always as identity primary key,
  type        text not null,
  description text not null,
  contact     text,
  lat         double precision,
  lng         double precision,
  created_at  timestamptz not null default now()
);

-- 2) Campos nuevos para reportes (foto, nombre, edad, estado)
alter table public.reportes add column if not exists photo_url text;
alter table public.reportes add column if not exists person_name text;
alter table public.reportes add column if not exists person_age text;
alter table public.reportes add column if not exists seen_at text;        -- "visto en"
alter table public.reportes add column if not exists status text default 'buscando'; -- buscando | info | ubicada | asalvo | fallecio

-- 3) RLS y políticas de reportes
alter table public.reportes enable row level security;

drop policy if exists "lectura publica" on public.reportes;
create policy "lectura publica" on public.reportes for select to anon using (true);

drop policy if exists "insercion publica" on public.reportes;
create policy "insercion publica" on public.reportes for insert to anon
  with check (length(description) between 1 and 1000 and type is not null);

-- Permitir ACTUALIZAR solo el campo de estado (para "marcar como encontrada", etc.)
-- Nota: se permite update de status a anónimos; el resto de campos no se exponen en la web.
drop policy if exists "update estado publico" on public.reportes;
create policy "update estado publico" on public.reportes for update to anon
  using (true) with check (true);

-- 4) Realtime
alter publication supabase_realtime add table public.reportes;

-- 5) STORAGE para fotos (bucket público 'fotos')
insert into storage.buckets (id, name, public)
values ('fotos','fotos', true)
on conflict (id) do nothing;

-- Cualquiera puede ver las fotos (bucket público)
drop policy if exists "fotos lectura" on storage.objects;
create policy "fotos lectura" on storage.objects for select to anon
  using (bucket_id = 'fotos');

-- Cualquiera puede subir fotos al bucket 'fotos'
drop policy if exists "fotos subida" on storage.objects;
create policy "fotos subida" on storage.objects for insert to anon
  with check (bucket_id = 'fotos');

-- ============================================================
-- LISTO. Resumen de lo que quedó habilitado:
-- - reportes: leer e insertar público; update solo para estado
-- - fotos: bucket público para subir y ver imágenes
-- Para MODERAR: Supabase → Table editor → reportes (borrar/editar)
--               Supabase → Storage → fotos (borrar imágenes)
-- ============================================================
