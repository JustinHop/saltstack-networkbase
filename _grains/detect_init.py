# Import python libs
import os
import re

# Import third party libs
#import yaml
import logging

# Import salt libs
import salt.utils

log = logging.getLogger(__name__)


def pid_one_info():
    grains = {}
    procfile = "/proc/1/cmdline"
    if os.path.isfile(procfile):
        with salt.utils.fopen(procfile, 'rb') as fp_:
            try:
                cmd = fp_.read()
                grains['init_cmd_full'] = cmd
                log.info(" ".join(['init_cmd_full =',
                                   grains['init_cmd_full'], ' .']))
                grains['init_cmd'] = os.path.basename(cmd)
                log.info(" ".join(['init_cmd = ', grains['init_cmd'], '.']))
                if re.match(r'.*/(systemd)', cmd):
                    grains['init'] = 'systemd'
                    grains['systemd'] = True
                else:
                    grains['init'] = 'sysv'
                    grains['sysv'] = True
                return grains
            except Exception:
                log.warn("Problem with pid_one_info.")
                return {}

    return {}
