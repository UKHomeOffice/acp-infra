[1mdiff --git a/route_tables.tf b/route_tables.tf[m
[1mindex 024785f..f75baa4 100644[m
[1m--- a/route_tables.tf[m
[1m+++ b/route_tables.tf[m
[36m@@ -8,8 +8,9 @@[m [mresource "aws_route_table" "default" {[m
   }[m
 [m
   tags {[m
[31m-    Env  = "${var.environment}"[m
[31m-    Name = "${var.environment}-default-rt"[m
[32m+[m[32m    Env               = "${var.environment}"[m
[32m+[m[32m    Name              = "${var.environment}-default-rt"[m
[32m+[m[32m    KubernetesCluster = "${var.environment}"[m
   }[m
 }[m
 [m
[1mdiff --git a/subnets.tf b/subnets.tf[m
[1mindex 44667ac..147c603 100644[m
[1m--- a/subnets.tf[m
[1m+++ b/subnets.tf[m
[36m@@ -6,9 +6,10 @@[m [mresource "aws_subnet" "default_subnets" {[m
   cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.default_subnet_offset)}"[m
 [m
   tags {[m
[31m-    Env  = "${var.environment}"[m
[31m-    Name = "${var.environment}--default-az${count.index}"[m
[31m-    Role = "default-subnets"[m
[32m+[m[32m    Env               = "${var.environment}"[m
[32m+[m[32m    Role              = "default-subnets"[m
[32m+[m[32m    Name              = "${var.environment}--default-az${count.index}"[m
[32m+[m[32m    KubernetesCluster = "${var.environment}"[m
   }[m
 }[m
 [m
[36m@@ -26,9 +27,10 @@[m [mresource "aws_subnet" "nat_subnets" {[m
   cidr_block        = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.nat_subnet_offset)}"[m
 [m
   tags {[m
[31m-    Env  = "${var.environment}"[m
[31m-    Role = "nat-subnets"[m
[31m-    Name = "${var.environment}-nat-az${count.index}"[m
[32m+[m[32m    Env               = "${var.environment}"[m
[32m+[m[32m    Role              = "nat-subnets"[m
[32m+[m[32m    Name              = "${var.environment}-nat-az${count.index}"[m
[32m+[m[32m    KubernetesCluster = "${var.environment}"[m
   }[m
 }[m
 [m
[36m@@ -49,6 +51,7 @@[m [mresource "aws_subnet" "elb_subnets" {[m
     Env                               = "${var.environment}"[m
     Role                              = "elb-subnets"[m
     Name                              = "${var.environment}-elb-az${count.index}"[m
[32m+[m[32m    KubernetesCluster                 = "${var.environment}"[m
     "kubernetes.io/role/internal-elb" = "true"[m
     "kubernetes.io/role/elb"          = "true"[m
   }[m
[1mdiff --git a/vpc.tf b/vpc.tf[m
[1mindex 85fd4f1..cc83aaf 100644[m
[1m--- a/vpc.tf[m
[1m+++ b/vpc.tf[m
[36m@@ -2,7 +2,9 @@[m [mresource "aws_vpc" "main" {[m
   cidr_block = "${var.vpc_cidr}"[m
 [m
   tags {[m
[31m-    Env    = "${var.environment}"[m
[31m-    Name   = "${var.environment}-vpc"[m
[32m+[m[32m    Env               = "${var.environment}"[m
[32m+[m[32m    Name              = "${var.environment}-vpc"[m
[32m+[m[32m    KubernetesCluster = "${var.environment}"[m
   }[m
[32m+[m
 }[m
