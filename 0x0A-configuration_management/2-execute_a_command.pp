# Kill a running process

exec {'_killmenow':
  command => '/usr/bin/pkill -f killmenow',
}
