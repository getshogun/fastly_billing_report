#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

require_relative '../lib/report'
Report.export(12)
