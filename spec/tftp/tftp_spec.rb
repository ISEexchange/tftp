# encoding: utf-8
require 'spec_helper'

describe 'tftpd' do
  before :all do
    @cid = `docker run -d -p 69:69/udp -e FQDN=KS.FQDN jumanjiman/tftp`
    @cid.chomp!
    ip = `ip route get 8.8.8.8 | awk '/src/{print $NF}'`
    @tftp = Net::TFTP.new(ip)
  end

  after :all do
    @tftp = nil
    `docker stop #{@cid}`
    `docker rm #{@cid}`
  end

  it 'host must support tftp nat' do
    result = system('lsmod | grep nf_nat_tftp &> /dev/null')
    result.should be_true
  end

  it 'container should serve pxelinux.0' do
    dst_path = File.join(Dir.tmpdir, 'pxelinux.0')
    result = @tftp.getbinaryfile('pxelinux.0', dst_path)
    result.should be_true
  end

  it 'container should serve pxelinux.cfg/default' do
    dst_path = File.join(Dir.tmpdir, 'default')
    src_path = File.join(
      RSpec.configuration.fixture_path, 'src', 'tftpboot', 'default'
    )

    result = @tftp.getbinaryfile('pxelinux.cfg/default', dst_path)
    result.should be_true

    src_md5 = Digest::MD5.hexdigest(File.read(src_path))
    dst_md5 = Digest::MD5.hexdigest(File.read(dst_path))
    src_md5.should eql dst_md5
  end
end
