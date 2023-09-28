# Install and Configure nginx: implement a direction and also create a customer 404 page
exec { 'update':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure  => 'installed',
}

file { 'homepage':
  ensure  => 'file',
  path    => '/var/www/html/index.html',
  content => 'Hello World!',
}

file { '404-page':
  ensure  => 'file',
  path    => '/var/www/html/404.html',
  content => 'Ceci n\'est pas une page',
}
$new_str="	location = /redirect_me {
			return 301 https://www.youtube.com/watch?v=_S7WEVLbQ-Y;
		}"

file_line {'redirect':
  ensure => present,
  line   => $new_str,
  match  => '^}$',
  before => '^}$',
  path   => '/etc/nginx/sites-available/default',
}

$err_str="	location = /404.html {
			internal;
		}"

exec {'handle_404':
  ensure => present,
  line   => $err_str,
  match  => '^}$',
  before => '^}$',
  path   => '/etc/nginx/sites-available/default',
}

service {'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}
