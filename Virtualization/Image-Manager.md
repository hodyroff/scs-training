## Image Manager

### Purpose
* Cloud providers must allow users to upload their own images (within fair use limits)
* For convenience, we recommend they offer public images that are centrally maintained
    - This saves work to customers by not having to upload standard vanilla upstream images
    - And it avoids the need to repeat this regularly to include the latest bug- and security fixes
    - Customization is then done via *user-data* injected at boot and typically consumed by `cloud-init`
* To make them really useful, users need to know what the policies of these images are
    - SCS has specified mandatory metadata (properties) for images in standard [scs-0102](https://docs.scs.community/standards/scs-0102-v1-image-metadata)
    - The metadata specifies technical settings (`architecture`, `os_version`, `min_disk`, `min_ram`),
      image handling policies (`replace_frequency`), image information (`image_source`, `image_build_date`,
      `image_original_user`), licensing information (only required for commercial OSes).
* The Image Manager helps the cloud operator to register compliant public images and to regularly
  provide updated versions of them.

### Usage
* On the manager node, run
```bash
dragon@testbed-manager(test):~ [0]$ osism manage image --help
usage: osism manage image [-h] [--no-wait] [--dry-run] [--hide] [--delete] [--latest] [--cloud CLOUD]
                          [--filter FILTER] [--images IMAGES]

options:
  -h, --help            show this help message and exit
  --no-wait             Do not wait until image management has been completed
  --dry-run             Do not perform any changes
  --hide                Hide images that should be deleted
  --delete              Delete images that should be deleted
  --latest              Only import the latest version for images of type multi
  --cloud CLOUD
                        Cloud name in clouds.yaml
  --filter FILTER
                        Filter images with a regex on their name
  --images IMAGES
                        Path to the directory containing all image files or path to single image file
```

### Exaaple
* Example: Register AlmaLinux 9
```bash
dragon@testbed-manager(test):~ [0]$ osism manage image --cloud admin --latest --filter "AlmaLinux"`
2025-05-09 16:44:43 | INFO     | It takes a moment until task 27d41583-8bca-4518-a861-81b101fe3cf2 (image-manager) has been started and output is visible here.
2025-05-09 16:44:45 | INFO     | Processing image 'AlmaLinux 9 (20241120)'
2025-05-09 16:44:45 | INFO     | Tested URL https://swift.services.a.regiocloud.tech/swift/v1/AUTH_b182637428444b9aa302bb8d5a5a418c/openstack-images/almalinux-9/20241120-almalinux-9.qcow2: 200
2025-05-09 16:44:45 | INFO     | Importing image AlmaLinux 9 (20241120)
2025-05-09 16:44:45 | INFO     | Importing from URL https://swift.services.a.regiocloud.tech/swift/v1/AUTH_b182637428444b9aa302bb8d5a5a418c/openstack-images/almalinux-9/20241120-almalinux-9.qcow2
2025-05-09 16:44:46 | INFO     | Waiting for image to leave queued state...
2025-05-09 16:44:48 | INFO     | Waiting for import to complete...
2025-05-09 16:44:58 | INFO     | Waiting for import to complete...
[...]
2025-05-09 16:49:10 | INFO     | Waiting for import to complete...
2025-05-09 16:49:20 | INFO     | Import of 'AlmaLinux 9 (20241120)' successfully completed, reloading images
2025-05-09 16:49:20 | INFO     | Checking parameters of 'AlmaLinux 9 (20241120)'
2025-05-09 16:49:20 | INFO     | Setting internal_version = 20241120
2025-05-09 16:49:20 | INFO     | Setting image_original_user = almalinux
2025-05-09 16:49:20 | INFO     | Adding tag os:centos
2025-05-09 16:49:20 | INFO     | Setting property architecture: x86_64
2025-05-09 16:49:21 | INFO     | Setting property hw_disk_bus: scsi
2025-05-09 16:49:21 | INFO     | Setting property hw_rng_model: virtio
2025-05-09 16:49:21 | INFO     | Setting property hw_scsi_model: virtio-scsi
2025-05-09 16:49:21 | INFO     | Setting property hw_watchdog_action: reset
2025-05-09 16:49:21 | INFO     | Setting property hypervisor_type: qemu
2025-05-09 16:49:21 | INFO     | Setting property os_distro: centos
2025-05-09 16:49:21 | INFO     | Setting property os_version: 9
2025-05-09 16:49:21 | INFO     | Setting property replace_frequency: quarterly
2025-05-09 16:49:22 | INFO     | Setting property uuid_validity: last-3
2025-05-09 16:49:22 | INFO     | Setting property provided_until: none
2025-05-09 16:49:22 | INFO     | Setting property image_description: AlmaLinux 9
2025-05-09 16:49:22 | INFO     | Setting property image_name: AlmaLinux 9
2025-05-09 16:49:22 | INFO     | Setting property internal_version: 20241120
2025-05-09 16:49:22 | INFO     | Setting property image_original_user: almalinux
2025-05-09 16:49:22 | INFO     | Setting property image_source: https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2
2025-05-09 16:49:23 | INFO     | Setting property image_build_date: 2024-11-20
2025-05-09 16:49:23 | INFO     | Checking status of 'AlmaLinux 9 (20241120)'
2025-05-09 16:49:23 | INFO     | Checking visibility of 'AlmaLinux 9 (20241120)'
2025-05-09 16:49:23 | INFO     | Setting visibility of 'AlmaLinux 9 (20241120)' to 'public'
2025-05-09 16:49:23 | INFO     | Renaming AlmaLinux 9 (20241120) to AlmaLinux 9
```
* Image was converted to raw to allow for Copy-on-Write usage with ceph
    - This took a bit of time (4min30s) on ceph on the testbed's ceph
