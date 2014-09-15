require 'pathname'

Puppet::Type.newtype(:xldeploy_plugin_netinstall) do

  desc 'download and unpack a xldeploy archive file from the interwebs'

  autorequire(:xldeploy_netinstall) do
    requires = []
    catalog.resources.each {|d|
      if (d.class.to_s == "Puppet::Type::Xldeploy_netinstall")
        requires << d.name
      end
    }
    requires
  end

  ensurable do
    desc "xldeploy_netinstall resource state"

    defaultto(:present)

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end
  end



  newparam(:name, :namevar => true) do
    desc 'the name of the required plugin'
  end

  newparam(:plugin_dir) do
    desc 'xldeploy_plugin dir'

    defaultto '/opt/xl-deploy/xl-deploy-server/plugins'

    validate do |value|

      fail('invalid pathname') unless Pathname.new(value).absolute?

    end
  end

  newparam(:proxy_url) do
    desc 'http proxy url'
  end

  newparam(:user) do
    desc 'download user'
  end

  newparam(:password) do
    desc 'download password'
  end

  newparam(:version) do
    desc 'the version of the plugin to download'
  end

  newparam(:base_download_url) do
    desc 'the base url where the plugins can be found'
    defaultto 'https://tech.xebialabs.com/download/plugins'
  end

  newparam(:distribution) do
    desc 'if this parameters is answered with yes the i guess we have to download a whole bundle of crap'
    defaultto false
  end

  newproperty(:owner) do
    desc 'the owner setting of the plugin jar file'
    defaultto 'xldeploy'
  end

  newproperty(:group) do
    desc 'the group setting of the plugin jar file'
    defaultto 'xldeploy'
  end



end