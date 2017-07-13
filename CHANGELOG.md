**v0.0.3**

* Removing the aws-region variable and leaving an empty provider, will be pulled from environment
* Specifying the availability zones rather than pulling them due so you can choose
* Adding some extra comments as helpers
* Adding an optional cloudtrail resource if a bucket is specified

**v0.0.2**

* Added some outputs from the module itself
* Added the kubernetes subnet's tags to the ELB and NAT subnets
* Added the tag Role to the subnet's themselves
* Added a changelog to keep notes
