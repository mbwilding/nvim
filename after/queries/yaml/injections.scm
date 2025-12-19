; extends

; Bash
(block_mapping_pair
  key: (flow_node) @key
    (#any-of? @key "script" "run" "bash" "sh" "before_script" "after_script" "inlineScript")
  value: (block_node (block_scalar) @injection.content)
  (#set! injection.language "bash")
  (#offset! @injection.content 0 1 0 0)
)

(block_mapping_pair
  key: (flow_node) @key
    (#any-of? @key "script" "run" "bash" "sh" "before_script" "after_script" "inlineScript")
  value: (flow_node (plain_scalar) @injection.content)
  (#set! injection.language "bash")
)

; Powershell
(block_mapping_pair
  key: (flow_node) @key
    (#any-of? @key "pwsh" "powershell" "inlineScript")
  value: (block_node (block_scalar) @injection.content)
  (#set! injection.language "powershell")
  (#offset! @injection.content 0 1 0 0)
)

(block_mapping_pair
  key: (flow_node) @key
    (#any-of? @key "pwsh" "powershell" "inlineScript")
  value: (flow_node (plain_scalar) @injection.content)
  (#set! injection.language "powershell")
)
