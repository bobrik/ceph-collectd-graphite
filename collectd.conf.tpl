Hostname "{{ HOST_NAME }}"

FQDNLookup false
Interval 10
Timeout 2
ReadThreads 5

LoadPlugin write_graphite

<Plugin "write_graphite">
 <Carbon>
   Host "{{ GRAPHITE_HOST }}"
   Port "{{ GRAPHITE_PORT | default("2003") }}"
   Protocol "tcp"
   Prefix "{{ GRAPHITE_PREFIX | default("collectd.") }}"
   StoreRates true
   AlwaysAppendDS false
   SeparateInstances true
 </Carbon>
</Plugin>

<LoadPlugin "python">
    Globals true
</LoadPlugin>

<Plugin "python">
    ModulePath "/usr/lib/collectd/plugins/ceph"

    Import "ceph_pool_plugin"

    <Module "ceph_pool_plugin">
        Verbose "True"
        Cluster "{{ CEPH_CLUSTER_NAME }}"
        Interval "{{ GRAPHITE_UPDATE_INTERVAL | default("30") }}"
    </Module>

    Import "ceph_monitor_plugin"

    <Module "ceph_monitor_plugin">
        Verbose "True"
        Cluster "{{ CEPH_CLUSTER_NAME }}"
        Interval "{{ GRAPHITE_UPDATE_INTERVAL | default("30") }}"
    </Module>

    Import "ceph_osd_plugin"

    <Module "ceph_osd_plugin">
        Verbose "True"
        Cluster "{{ CEPH_CLUSTER_NAME }}"
        Interval "{{ GRAPHITE_UPDATE_INTERVAL | default("30") }}"
    </Module>

    Import "ceph_pg_plugin"

    <Module "ceph_pg_plugin">
        Verbose "True"
        Cluster "{{ CEPH_CLUSTER_NAME }}"
        Interval "{{ GRAPHITE_UPDATE_INTERVAL | default("30") }}"
    </Module>

    Import "ceph_latency_plugin"

    <Module "ceph_latency_plugin">
        Verbose "True"
        Cluster "{{ CEPH_CLUSTER_NAME }}"
        Interval "{{ GRAPHITE_UPDATE_INTERVAL | default("30") }}"
    </Module>
</Plugin>
