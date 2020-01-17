 #!/bin/bash

for i in {1..50}; do ping -c1 8.8.8.8 &> /dev/null && break; done
