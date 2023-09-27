# Install and Configure nginx: implement a direction and also create a customer 404 page
exec { 'update':
  command => '/usr/bin/apt-get update -y',
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update'],
}

file { 'homepage':
  ensure  => 'file',
  path    => '/var/www/html/index.html',
  content => 'Hello World!',
}

file { '404-page':
  ensure  => 'file',
  path    => '/var/www/html/404.html',
  content => 'Sorry, Not Sorry (Ceci n\'est pas une page) Ahahah',
}
$new_str="\tlocation = /redirect_me {\n\t\treturn 301 https://www.youtube.com/watch?v=_S7WEVLbQ-Y;\n\t}"

exec {'redirect':
  command => 'sed -i \'/^}$/i \ \'"$new_str" /etc/nginx/sites-available/default'
}

$err_str="\tlocation = /404.html {\n\t\tinternal;\n\t}"

exec {'handle_404':
  command => 'sed -i \'/^}$/i \ \'"$err_str" /etc/nginx/sites-available/default'
}

service {'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}
