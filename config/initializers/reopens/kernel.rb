module Kernel
  #=====================================
  # Kernel#compact
  #=====================================
  def compact *args
    # arg make
    args  = args.first if Array === args.first
    args  = args.map &:to_sym

    # local vars make
    lvars = binding.of_caller(1).send(:eval, 'local_variables').map &:to_sym

    # keys marge => get values
    keys  = args & lvars
    keys.inject([]){|arr, key|
      val = binding.of_caller(2).send :eval, key.to_s
      arr.push [key, val]
    }
    .to_h
  end
end
