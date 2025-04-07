# Write-Host "🔨 Building image..."
docker-compose build

# Write-Host "🚀 Starting container..."
docker-compose run --rm devbox
