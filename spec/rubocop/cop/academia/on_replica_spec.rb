# frozen_string_literal: true

require 'spec_helper'
require 'rubocop'
require 'rubocop/rspec/cop_helper'
require 'rubocop/config'
require 'rubocop/cop/academia/on_replica'

describe RuboCop::Cop::Academia::OnReplica do
  include CopHelper

  let(:config) { RuboCop::Config.new }

  subject(:cop) { described_class.new(config) }

  it "registers an offense when using User.on_replica" do
    inspect_source(<<~RUBY)
      User.on_replica.do_something
    RUBY

    expect(cop.offenses.size).to eq(1)
    expect(cop.messages).to eq([described_class::MSG])
  end

  it "registers an offense wehn using Octopus.on_replica with no args" do
    inspect_source(<<~RUBY)
      Octopus.on_replica do
        User.do_something
      end
    RUBY

    expect(cop.offenses.size).to eq(1)
    expect(cop.messages).to eq([described_class::MSG])
  end

  it "does not register an offense when using Octopus.on_replica(:main)" do
    inspect_source(<<~RUBY)
      Octopus.on_replica(:main) do
        User.do_something
      end
    RUBY

    expect(cop.offenses).to be_empty
  end

  it "does not register an offense when using PremiumAnalytics.on_replica" do
    inspect_source(<<~RUBY)
      PremiumAnalytics.on_replica.do_something
    RUBY

    expect(cop.offenses).to be_empty
  end

  it "does not register an offense when defining on_replica" do
    inspect_source(<<~RUBY)
      def on_replica(shard = :main)
        do_something
      end

      def self.on_replica(shard = :main)
        do_something_else
      end
    RUBY

    expect(cop.offenses).to be_empty
  end
end
