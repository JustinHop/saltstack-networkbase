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

    try:
        hostparts = re.match(r'^(\w+)(\d+)\.(\w+)\.hnh$', fqdn)
        grains['class'] = hostparts.group(1)
        grains['class_instance'] = hostparts.group(2)
        grains['cluster'] = hostparts.group(3)
        grains['tld'] = 'hnh'
        grains['security_level'] = 'internal'
        host_based_info_show(grains)
        return grains
    except:
        pass
        #log.info("not a proper hnh name")

    try:
        hostparts = re.match(
            r'^(\D+)(\d+)\.(\w+)\.(\w)(\D+)(\d+)\.(\w+)\.(\w+)$', fqdn)
        grains['class'] = hostparts.group(1)
        grains['class_instance'] = hostparts.group(2)
        grains['product'] = hostparts.group(3)
        if hostparts.group(4) == 'd':
            grains['grade'] = 'dev'
        elif hostparts.group(4) == 'q':
            grains['grade'] = 'qa'
        elif hostparts.group(4) == 's':
            grains['grade'] = 'stage'
        elif hostparts.group(4) == 'c':
            grains['grade'] = 'cap'
        elif hostparts.group(4) == 'p':
            grains['grade'] = 'prod'
        elif hostparts.group(4) == 'v':
            grains['grade'] = 'virtual'
        grains['cluster'] = hostparts.group(5)
        grains['cluster_instance'] = hostparts.group(6)
        grains['business'] = hostparts.group(7)
        grains['tld'] = hostparts.group(8)
        host_based_info_show(grains)
        return grains
    except:
        pass
        #log.info("not a proper tmcs name")

    log.warn("host_based has failed")
    grains['security_level'] = ''
    return grains
