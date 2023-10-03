#install nginx and configure
$str = 'location / {'
$custom_head = 'location / {\
		add_header X-Served-By \$hostname;\
		'
exec { 'update':
  command  => 'sudo apt-get update -y',
  provider => shell,
}

-> exec { 'install_nginx':
  command  => 'sudo apt-get install nginx -y',
  provider => shell,
}

-> exec { 'custom_header':
  command  => "sed -i -z 's|${str}|${custom_head}|' /etc/nginx/sites-available/default",
  provider => shell,
}

-> exec { 'restart':
  command  => 'sudo service nginx restart',
  provider => shell,
}
