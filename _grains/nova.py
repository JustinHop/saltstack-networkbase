# -*- coding: utf-8 -*-
"""
Module to provide Rackspace infrastructure compatibility to Salt.

:depends: pyrax Rackspace python SDK
:maintainer: Justin Hoppensteadt <hop@crowdrise.com>
:maturity: new
:platform: all
:configuration:
    The following values are required to be present in pillar for this module
    to work::
        rackspace:
            username: USERNAME
            apikey: API_KEY

"""

# Import Python libs
import six
import logging
import os

logger = logging.getLogger(__name__)
pyrax_log = logging.getLogger('pyrax')
urllib3_log = logging.getLogger('urllib3')

# Import salt libs
import salt.utils

#Import pyrax
HAS_PYRAX = False
try:
    import pyrax
    import pyrax.exceptions as exc

    HAS_PYRAX = True
    pyrax.set_setting("identity_type", "rackspace")
except ImportError:
    logger.error("Could not import Pyrax")

#TODO: Add Absent Modules
#TODO: Add Get Modules

__virtualname__ = 'hopnova'

def __virtual__():
    if HAS_PYRAX:
        pyrax_log.setLevel('CRITICAL')
        urllib3_log.setLevel('CRITICAL')
    return HAS_PYRAX


#Global variables that aren't available from pyrax
MAX_DB_VOLUME_SIZE = 150
MINIMUM_TTL = 300
PAGE_SIZE = 100
TIMEOUT = 30

#DNS
VALID_RECORD_TYPES = ['A', 'AAAA', 'CNAME', 'MX' 'NS', 'PTR', 'SRV', 'TXT']
PRIORITY_RECORD_TYPES = ["MX", 'SRV']


def _auth():
    """
    Authenticates against the rackspace api based on values found in pillar
    """
    rackspace = {'username': 'justin.hoppensteadt',
                 'apikey': '993ee403ca934d5cbed5f79e4de5b8c6'}
    username = rackspace['username']
    apikey = rackspace['apikey']
    urllib3_logger = logging.getLogger('urllib3')
    urllib3_logger.setLevel(logging.CRITICAL)

    try:
        #pyrax.set_credentials(username, apikey)
        creds_file = os.path.expanduser("~/.pyrax.cfg")
        pyrax.set_credential_file(creds_file)
    except exc.AuthenticationFailed:
        logger.error(
            u"Unable to authenticate with the provided credentials, "
            u"{0}, {1}, {2}".format(username, apikey, rackspace)
        )

def _get_driver(driver_type, region='ORD'):
    """
    Returns the appropriate diver for the specified rackspace product.

    Available options include::
        lb: Cloud Load Balancers
        db: Cloud Databases
        dns: Cloud DNS
        bs: Cloud Block Storage
        mon: Cloud Monitoring
        net: Cloud Networks
        cf: Cloud Files
        cs: Cloud Servers

    :param driver_type: A str or unicode object for the appropriate type of
    driver above.
    :param region: A str or unicode object specify which region the driver
    should be initialized for.
    :return: A driver object initialized to the specified region
    :raise TypeError:
    :raise KeyError: If no valid drivers are found
    """
    _auth()
    if not isinstance(driver_type, six.string_types):
        raise TypeError("driver_type must be str or unicode object")
    if not isinstance(region, six.string_types):
        raise TypeError("region must be str or unicode object")
    region = region.upper()

    if driver_type == "lb":
        return pyrax.connect_to_cloud_loadbalancers(region)

    if driver_type == "db":
        return pyrax.connect_to_cloud_databases(region)

    if driver_type == "dns":
        return pyrax.connect_to_cloud_dns()

    if driver_type == "bs":
        return pyrax.connect_to_cloud_blockstorage(region)

    if driver_type == "mon":
        return pyrax.connect_to_cloud_monitoring(region)

    if driver_type == "net":
        return pyrax.connect_to_cloud_networks(region)

    if driver_type == 'cf':
        return pyrax.connect_to_cloudfiles(region)

    if driver_type == 'cs':
        return pyrax.connect_to_cloudservers(region)

    raise KeyError(u"No Driver found by: {}".format(driver_type))


def cs_grains():
    """
    Returns a list of all nova servers

    :return: Grain of nova output
    """

    driver = _get_driver('cs')
    #assert isinstance(driver, pyrax.clouddns.CloudDNSClient)
    output = []
    try:
        for server in driver.servers.list():
            try:
                o = server.to_dict()
                output.append(o)
            except:
                pass
        return({'nova': output})
    except:
        pass

def clb_grains():
    """
    Returns a list of all cloud load balancers

    :return: Grain of lb output
    """

    driver = _get_driver('lb')
    #assert isinstance(driver, pyrax.clouddns.CloudDNSClient)
    output = []
    try:
        for lb in driver.list():
            try:
                pvip = []
                try:
                    for ip in lb.virtualIps:
                        pvip.append("%s" % (ip.address))
                except(AttributeError):
                    pass
                output.append({'id': lb.id, 'name': lb.name, 'addresses': pvip,
                        'port': lb.port, 'protocol': lb.protocol, 'status': lb.status})
            except:
                pass
        return({'loadbalancers': output})
    except:
        pass
