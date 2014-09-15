# encoding: utf-8
require 'spec_helper'

describe 'jumanjiman/tftp' do
  before :all do
    @docker_version = Gem::Version.new(Docker.version['Version'])
    if @docker_version >= Gem::Version.new('0.9')
      key, repo = 'RepoTags', 'jumanjiman/tftp:latest'
      @image = Docker::Image.all.find { |i| i.info[key].include?(repo) }
    else
      key, repo = 'Repository', 'jumanjiman/tftp'
      @image = Docker::Image.all.find { |i| i.info[key] == repo }
    end
    pp Docker::Image.all unless @image
  end

  describe 'image' do
    it 'should be available' do
      @image.should_not be_nil
    end
  end

  describe 'docker' do
    before :each do
      @config = @image.json['config'] || @image.json['ContainerConfig']
    end

    it 'should expose tftp port and only tftp port' do
      @config['ExposedPorts'].keys.should =~ ['69/udp']
    end
  end
end
