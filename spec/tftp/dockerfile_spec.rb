# encoding: utf-8
require 'spec_helper'

describe 'jumanjiman/tftp' do
  describe 'api version' do
    it 'should be valid' do
      Docker.validate_version!.should be_truthy
    end
  end

  describe 'image' do
    it 'should be available' do
      Docker::Image.exist?('jumanjiman/tftp').should be_truthy
    end
  end

  describe 'docker' do
    before :each do
      @config = Docker::Image.get('jumanjiman/tftp').info['Config']
    end

    it 'should expose tftp port and only tftp port' do
      @config['ExposedPorts'].keys.should =~ ['69/udp']
    end
  end
end
