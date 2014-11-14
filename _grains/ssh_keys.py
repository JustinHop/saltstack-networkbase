def ssh_host_keys():
    _key_types = ['dsa', 'rsa', 'ecdsa', 'ed25519']
    _keys = {}
    for _type in _key_types:
        try:
            _pub_key = "ssh_host_%s_key.pub" % (_type)
            _pub_key_file = "/etc/ssh/%s" % (_pub_key)
            _pub_key_cert = "ssh_host_%s_key-cert.pub" % (_type)
            _pub_key_cert_file = "/etc/ssh/%s" % (_pub_key_cert)
            _keys[_pub_key] = open(_pub_key_file).read().rstrip()
            _keys[_pub_key_cert] = open(_pub_key_cert_file).read().rstrip()
        except IOError:
            pass

    return _keys
