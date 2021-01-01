# freebsd-update

{% from "jails/map.jinja" import jails with context %}

{% for cfg in jails.instances if cfg.present %}
{% set jail = cfg.name %}

{{ jail }}_freebsd_update_fetch_install:
  cmd.run:
    - name: freebsd-update --not-running-from-cron --currently-running {{ cfg.version }} -b {{ jails.root | path_join(jail) }} -f {{ jails.root | path_join(jail, 'etc', 'freebsd-update.conf') }} -d {{ jails.root | path_join(jail, 'var', 'db', 'freebsd-update') }} fetch install
    - cwd: /tmp
    # FIXME breaks highstate completion
    # - parallel: True

{% endfor %}
