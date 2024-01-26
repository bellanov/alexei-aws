#!/bin/bash
sudo dnf update -y
sudo dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl is-enabled httpd
sudo chmod 777 /var/www/html
cat > /var/www/html/index.php <<'END'
<?php
$instance_id = file_get_contents("http://instance-data/latest/meta-data/instance-id");
echo "You've reached instance ", $instance_id, "\n";
?>
END
ls -la /var/www/