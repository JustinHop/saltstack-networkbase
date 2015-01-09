# -*- coding: utf-8 -*-
# Import python libs
import re
import socket

# Import third party libs
#import yaml
import logging

# Import salt libs
#import salt.utils
#import salt.utils.network

log = logging.getLogger(__name__)


def host_based_info_show(grains={'test': 'value'}):
    for grain in grains:
        ginfo = "grain %s : %s" % (grain, grains[grain])
        log.info(ginfo)


def host_based_info():
    grains = {}
    fqdn = socket.getfqdn()

    # Memory Shortcuts
    meminfofile = open('/proc/meminfo').read()
    memfind = re.search(r'^MemTotal:\s+(\d+)', meminfofile)
    if memfind:
        grains['mem100'] = int(memfind.groups()[0])
        grains['mem10'] = int(grains['mem100'] * .1)
        grains['mem20'] = int(grains['mem100'] * .2)
        grains['mem30'] = int(grains['mem100'] * .3)
        grains['mem40'] = int(grains['mem100'] * .4)
        grains['mem50'] = int(grains['mem100'] * .5)
        grains['mem60'] = int(grains['mem100'] * .6)
        grains['mem70'] = int(grains['mem100'] * .7)
        grains['mem80'] = int(grains['mem100'] * .8)
        grains['mem90'] = int(grains['mem100'] * .9)

    grains['class'] = "oldschool"
    grains['product'] = "sys"
    grains['cluster'] = "prod"
    grains['cluster_instance'] = "1"
    grains['business'] = "crowdrise"
    grains['tld'] = "io"

    try:
        hostparts = re.match(
            r'^(\D+)(\d+)\.(\w+)\.(\D+)(\d+)\.(\w+)\.(\w+)$', fqdn)
        grains['class'] = hostparts.group(1)
        grains['class_instance'] = hostparts.group(2)
        grains['product'] = hostparts.group(3)
        try:
            gitinfo = re.match(
                r'^(\w+)-(\w)$', grains['product'])
            grains['git_branch'] = gitinfo.group(1)
            grains['git_repo'] = gitinfo.group(1)
        except:
            pass
        grains['cluster'] = hostparts.group(4)
        grains['cluster_instance'] = hostparts.group(5)
        grains['business'] = hostparts.group(6)
        grains['tld'] = hostparts.group(7)
        host_based_info_show(grains)
        return grains
    except:
        pass

    log.warn("host_based has resorted to defaults")
    grains['security_level'] = ''
    return grains
