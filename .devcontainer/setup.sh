#!/bin/bash
set -e

echo "Setting up development environment..."

# Install Terraform
if ! command -v terraform &> /dev/null; then
    echo "Installing Terraform..."
    cd /tmp
    wget -q https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_amd64.zip
    unzip -q terraform_1.10.3_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    rm terraform_1.10.3_linux_amd64.zip
    echo "Terraform installed: $(terraform --version | head -1)"
fi

# Install gcloud SDK
if ! command -v gcloud &> /dev/null; then
    echo "Installing Google Cloud SDK..."
    cd ~
    curl -s https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir=$HOME
    echo 'source ~/google-cloud-sdk/path.bash.inc' >> ~/.bashrc
    echo "gcloud installed"
fi

# Install Python requirements if they exist
if [ -f .devcontainer/requirements.txt ]; then
    pip install --user -r .devcontainer/requirements.txt || echo 'No requirements.txt yet'
fi

echo "Setup complete!"
