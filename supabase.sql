-- Схема до июля: таблицы и доступ.
-- Выполнить один раз в Supabase → SQL Editor → New query → Run.
-- Каждая строка привязана к твоему логину, RLS не даёт читать чужое.

create table if not exists public.metrics (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id      text not null,
  name    text not null default '',
  unit    text not null default '',
  mode    text not null default 'level',   -- level | sum
  target  numeric,
  tdate   date,
  zero    boolean not null default false,
  ord     bigint  not null default 0,
  primary key (user_id, id)
);

create table if not exists public.weeks (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  d       date not null,
  vals    jsonb not null default '{}'::jsonb,
  note    text  not null default '',
  primary key (user_id, d)
);

create table if not exists public.rules (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id      text not null,
  ifs     text not null default '',
  thens   text not null default '',
  ord     bigint not null default 0,
  primary key (user_id, id)
);

create table if not exists public.marks (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id      text not null,
  side    text not null default 'before',
  text    text not null default '',
  ord     bigint not null default 0,
  primary key (user_id, id)
);

alter table public.metrics enable row level security;
alter table public.weeks   enable row level security;
alter table public.rules   enable row level security;
alter table public.marks   enable row level security;

drop policy if exists own_metrics on public.metrics;
drop policy if exists own_weeks   on public.weeks;
drop policy if exists own_rules   on public.rules;
drop policy if exists own_marks   on public.marks;

create policy own_metrics on public.metrics for all
  using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy own_weeks on public.weeks for all
  using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy own_rules on public.rules for all
  using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy own_marks on public.marks for all
  using (user_id = auth.uid()) with check (user_id = auth.uid());
