#!/bin/bash

psql postgres -U root<< EOF
drop table plan;
CREATE TABLE plan
(
  id INTEGER NOT NULL,
  typ INTEGER NOT NULL,
  dat TIMESTAMP,
  val TEXT NOT NULL
);
CREATE UNIQUE INDEX plan_id ON plan(id);
CREATE INDEX plan_typ ON plan(typ);
CREATE INDEX plan_dat ON plan(dat);
COPY plan FROM './plan.dat' (DELIMITER ',', NULL '');
EOF
