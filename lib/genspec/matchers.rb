require 'genspec/matchers/base'
require 'genspec/matchers/result_matcher'
require 'genspec/matchers/generation_method_matcher'
require 'genspec/matchers/output_matcher'

module GenSpec
  module Matchers
    # Valid types: :dependency, :class_collisions, :file, :template, :complex_template, :directory, :readme,
    # :migration_template, :route_resources
    #
    # Examples:
    #   expect(subject).to generate(:file, ...)
    #   expect(subject).to generate("vendor/plugins/will_paginate/init.rb")
    #
    def generate(kind = nil, *args, &block)
      if kind.kind_of?(Symbol)
        # expect(subject).to generate(:file, ...)
        call_action(kind, *args, &block)
      else
        # expect(subject).to generate("vendor/plugins/will_paginate/init.rb")
        GenSpec::Matchers::ResultMatcher.new(kind, &block)
      end
    end
    
    # Makes sure that the generator deletes the named file. This is done by first ensuring that the
    # file exists in the first place, and then ensuring that it does not exist after the generator
    # completes its run.
    #
    # Example:
    #   expect(subject).to delete("path/to/file")
    #
    def delete(filename)
      within_source_root do
        FileUtils.mkdir_p File.dirname(filename)
        FileUtils.touch   filename
      end
      
      generate { expect(File).not_to exist(filename) }
    end
    
    # ex:
    #   expect(subject).to call_action(:create_file, ...)
    #
    def call_action(kind, *args, &block)
      GenSpec::Matchers::GenerationMethodMatcher.for_method(kind, *args, &block)
    end
    
    # This tests the content sent to the command line, instead of the generated product.
    # Useful for testing help messages, etc.
    def output(text_or_regexp)
      GenSpec::Matchers::OutputMatcher.new(text_or_regexp)
    end
    
    class << self
      def add_shorthand_methods(base)
        instance_methods = base.instance_methods.collect { |m| m.to_s }
        
        # ex:
        #   expect(subject).to create_file(...)
        # equivalent to:
        #   expect(subject).to call_action(:create_file, ...)
        
        GenSpec::Matchers::GenerationMethodMatcher.generation_methods.each do |method_name|
          # don't overwrite existing methods. since the user expects this to fire FIRST,
          # it's as if this method's been "overridden". See #included and #extended.
          next if instance_methods.include?(method_name.to_s)
          base.class_eval <<-end_code
            # def create_file(*args, &block)
            #   call_action('create_file', *args, &block)
            # end
            def #{method_name}(*args, &block)
              call_action(#{method_name.inspect}, *args, &block)
            end
          end_code
        end 
      end
    end
  end
end
