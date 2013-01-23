proxy-connect
=============

Forwards remote services over proxy to local ports; local applications do not
need to be SOCKS-aware.

How To Use
==========

  You can specify proxy method in an environment variable or in a
  command line option.

  usage:  connect [-dnhst45N] [-R resolve] [-p local-port] [-w sec]
                  [-H [user@]proxy-server[:port]]
                  [-S [user@]socks-server[:port]]
                  [-T proxy-server[:port]]
                  [-c telnet proxy command]
                  host port

  "host" and "port" is for the target hostname and port-number to
  connect to.

  The -H option specifys a hostname and port number of the http proxy
  server to relay. If port is omitted, 80 is used. You can specify this
  value in the environment variable HTTP_PROXY and pass the -h option
  to use it.

  The -S option specifys the hostname and port number of the SOCKS
  server to relay.  Like -H, port number can be omitted and the default
  is 1080. You can also specify this value pair in the environment
  variable SOCKS5_SERVER and give the -s option to use it.

  The '-4' and the '-5' options are for specifying SOCKS relaying and
  indicates protocol version to use. It is valid only when used with
  '-s' or '-S'. Default is '-5' (protocol version 5)

  The '-R' option is for specifying method to resolve the
  hostname. Three keywords ("local", "remote", "both") or dot-notation
  IP address are acceptable.  The keyword "both" means, "Try local
  first, then remote". If a dot-notation IP address is specified, use
  this host as nameserver. The default is "remote" for SOCKS5 or
  "local" for others. On SOCKS4 protocol, remote resolving method
  ("remote" and "both") requires protocol 4a supported server.

  The '-p' option will forward a local TCP port instead of using the
  standard input and output.

  The '-P' option is same to '-p' except keep remote session. The
  program repeats waiting the port with holding remote session without
  disconnecting. To disconnect the remote session, send EOF to stdin or
  kill the program.

  The '-w' option specifys timeout seconds for making connection with
  TARGET host.

  The '-N' option selects for no authentication when it is available.
  Otherwise, connect.c defaults to use authentication.

  The '-d' option is used for debug. If you fail to connect, use this
  and check request to and response from server.

  You can omit the "port" argument when program name is special format
  containing port number itself. For example,
    $ ln -s connect connect-25
  means this connect-25 command is spcifying port number 25 already
  so you need not 2nd argument (and ignored if specified).

  To use proxy, this example is for SOCKS5 connection to connect to
  'host' at port 25 via SOCKS5 server on 'firewall' host.
    $ connect -S firewall  host 25
  or
    $ SOCKS5_SERVER=firewall; export SOCKS5_SERVER
    $ connect -s host 25

  For a HTTP-PROXY connection:
    $ connect -H proxy-server:8080  host 25
  or
    $ HTTP_PROXY=proxy-server:8080; export HTTP_PROXY
    $ connect -h host 25
  To forward a local port, for example to use ssh:
    $ connect -p 5550 -H proxy-server:8080  host 22
   ($ ssh -l user -p 5550 localhost )

TIPS
====

  Connect.c doesn't have any configuration to specify the SOCKS server.
  If you are a mobile user, this limitation might bother you.  However,
  You can compile connect.c and link with other standard SOCKS library
  like the NEC SOCKS5 library or Dante. This means connect.c is
  socksified and uses a configration file like to other SOCKSified
  network commands and you can switch configuration file any time
  (ex. when ppp startup) that brings you switching of SOCKS server for
  connect.c in same way with other commands. For this case, you can
  write ~/.ssh/config like this:

    ProxyCommand connect -n %h %p

SOCKS5 authentication
=====================

  Only USER/PASS authentication is supported.

Proxy authentication
====================

  Only BASIC scheme is supported.

Authentication informations
===========================

  User name for authentication is specifed by an environment variable
  or system login name.  And password is specified from environment
  variable or external program (specified in $SSH_ASKPASS) or tty.

  Following environment variable is used for specifying user name.
    SOCKS: $SOCKS5_USER, $LOGNAME, $USER
    HTTP Proxy: $HTTP_PROXY_USER, $LOGNAME, $USER

ssh-askpass support
===================

  You can use ssh-askpass (came from OpenSSH or else) to specify
  password on graphical environment (X-Window or MS Windows). To use
  this, set program name to environment variable SSH_ASKPASS. On UNIX,
  X-Window must be required, so $DISPLAY environment variable is also
  needed.  On Win32 environment, $DISPLAY is not mentioned.

Related Informations
====================

  SOCKS5 -- RFC 1928, RFC 1929, RFC 1961
            NEC SOCKS Reference Implementation is available from:
              http://www.socks.nec.com
            DeleGate version 5 or earlier can be SOCKS4 server,
            and version 6 can be SOCKS5 and SOCKS4 server.
            and version 7.7.0 or later can be SOCKS5 and SOCKS4a server.
              http://www.delegate.org/delegate/

  HTTP-Proxy --
            Many http proxy servers supports this, but https should
            be allowed as configuration on your host.
            For example on DeleGate, you should add "https" to the
            "REMITTABLE" parameter to allow HTTP-Proxy like this:
              delegated -Pxxxx ...... REMITTABLE="+,https" ...

 Hypertext Transfer Protocol -- HTTP/1.1  -- RFC 2616
 HTTP Authentication: Basic and Digest Access Authentication -- RFC 2617
            For proxy authentication, refer these documents.

License
=======
As mentioned in the sources, the code is available under the terms of GPLv2+.

Getting Source (stale)
======================

  Recent version of 'connect.c' is available from
    http://www.taiyo.co.jp/~gotoh/ssh/connect.c (Dead link now. -CEM)

  Related tool, ssh-askpass.exe (alternative ssh-askpass on UNIX)
  is available:
    http://www.taiyo.co.jp/~gotoh/ssh/ssh-askpass.exe.gz

  See more detail:
    http://www.taiyo.co.jp/~gotoh/ssh/connect.html
