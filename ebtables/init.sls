#!jinja|yaml

{% from "ebtables/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('ebtables:lookup')) %}

{% if datamap.ensure|default('installed') in ['absent', 'removed'] %}
  {% set pkgensure = 'removed' %}
{% else %}
  {% set pkgensure = 'installed' %}
{% endif %}

ebtables:
  pkg:
    - {{ pkgensure }}
    - pkgs: {{ datamap.pkgs }}
