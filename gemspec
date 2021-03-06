# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'test_bench_legacy'
  s.version = '1.3.5'

  s.authors = ['Nathan Ladd']
  s.homepage = 'https://github.com/WealthBar/test-bench-1.x'
  s.email = 'jf.arseneau@wealthbar.com'
  s.licenses = %w(MIT)
  s.summary = "The legacy version of a frugal test framework for Ruby"
  s.description = "Test Bench Legacy is the legacy version of a test framework for Ruby designed to offer the minimum set of features necessary to test well designed code effectively."

  s.executables = ['bench']
  s.bindir = 'bin'

  s.require_paths = %w(lib)
  s.files = Dir.glob 'lib/**/*'
  s.platform = Gem::Platform::RUBY
end
