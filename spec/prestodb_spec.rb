require 'serverspec'
require 'docker'

describe 'shawnzhu/prestodb' do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :backend, :docker
    set :docker_image, image.id
  end

  describe file('/opt/presto-server-0.193') do
    it { should be_directory }
  end

  describe file('/opt/presto') do
    it { should be_symlink }
  end

  describe file('/opt/presto/data') do
    it { should be_directory }
  end

  describe command('ls /opt/presto/etc/') do
    %w{catalog config.properties jvm.config node.properties}.each do |file|
      its(:stdout) { should contain(file) }
    end
  end
end
