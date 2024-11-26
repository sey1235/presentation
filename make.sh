#!/bin/sh
set -e
for diagram in diagrams/*.puml; do
  plantuml -tsvg "$diagram"
done

typst compile presentation.typ
