# encoding: utf-8
require 'spec_helper'

describe 'tftpd' do
  before :all do
    @cid = `docker run -d -p 69:69/udp -e FQDN=KS.FQDN jumanjiman/tftp`
    @cid.chomp!
    sleep 5 # allow time for tftpd to stabilize
    ip = `ip route get 8.8.8.8 | awk '/src/{print $NF}'`
    @tftp = Net::TFTP.new(ip)
    @tftp.timeout = 30

    modules = %w(
      nf_nat_tftp
      nf_conntrack_tftp
    )
    modules.each { |mod| `sudo modprobe #{mod}` }
  end

  after :all do
    @tftp = nil
    `docker stop #{@cid}`
    `docker rm #{@cid}`
  end

  it 'host must support tftp nat' do
    result = system('lsmod | grep -q nf_nat_tftp')
    result.should be_truthy
  end

  it 'host must support tftp connection tracking' do
    result = system('lsmod | grep -q nf_conntrack_tftp')
    result.should be_truthy
  end

  it 'container should serve pxelinux.0' do
    dst_path = File.join(Dir.tmpdir, 'pxelinux.0')
    result = @tftp.getbinaryfile('pxelinux.0', dst_path)
    result.should be_truthy
  end

  it 'container should serve pxelinux.cfg/default' do
    dst_path = File.join(Dir.tmpdir, 'default')
    src_path = File.join(
      RSpec.configuration.fixture_path, 'src', 'tftpboot', 'default'
    )

    result = @tftp.getbinaryfile('pxelinux.cfg/default', dst_path)
    result.should be_truthy

    src_md5 = Digest::MD5.hexdigest(File.read(src_path))
    dst_md5 = Digest::MD5.hexdigest(File.read(dst_path))
    src_md5.should eql dst_md5
  end
end
