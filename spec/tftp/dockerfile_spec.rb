# encoding: utf-8
require 'spec_helper'

describe 'ISEexchange/tftp' do
  before :all do
    @docker_version = Docker.version['Version']
    if @docker_version >= '0.9'
      key, repo = 'RepoTags', 'ISEexchange/tftp:latest'
      @image = Docker::Image.all.find { |i| i.info[key].include?(repo) }
    else
      key, repo = 'Repository', 'ISEexchange/tftp'
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
      @config = @image.json['config']
    end

    it 'should expose tftp port and only tftp port' do
      @config['ExposedPorts'].keys.should =~ ['69/udp']
    end
  end
end
