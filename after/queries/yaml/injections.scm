; extends

; --- Inject Bash and PowerShell for common CI pipeline fields ---

; Azure DevOps, GitHub Actions, GitLab CI (sh, bash, script, run, before_script, after_script as block_scalar)
(block_mapping_pair
  key: (flow_node) @key
    (#any-of? @key "script" "run" "bash" "sh" "before_script" "after_script" "inlineScript")
  value: (block_node (block_scalar) @injection.content)
  (#set! injection.language "bash")
  (#offset! @injection.content 0 1 0 0)
)

; Azure DevOps PowerShell
(block_mapping_pair
  key: (flow_node) @key
    (#any-of? @key "pwsh" "powershell" "inlineScript")
  value: (block_node (block_scalar) @injection.content)
  (#set! injection.language "powershell")
  (#offset! @injection.content 0 1 0 0)
)

; --- Support inline and plain string scenarios ---
(block_mapping_pair
  key: (flow_node) @key
    (#any-of? @key "script" "run" "bash" "sh" "before_script" "after_script" "inlineScript")
  value: (flow_node (plain_scalar) @injection.content)
  (#set! injection.language "bash")
)

(block_mapping_pair
  key: (flow_node) @key
    (#any-of? @key "pwsh" "powershell" "inlineScript")
  value: (flow_node (plain_scalar) @injection.content)
  (#set! injection.language "powershell")
)

; --- Variable/Template Interpolation ---
; Handles {{ }} and similar for gotmpl-like highlighting
(block_scalar) @injection.content
  (#match? @injection.content "\\{\\{\\s*[A-Za-z_.][A-Za-z0-9_.]*\\s*\\}\}")
  (#set! injection.language "gotmpl")

(block_scalar) @injection.content
  (#match? @injection.content "\\$\\{\\{[^}]+\\}\}")
  (#set! injection.language "gotmpl")

; Bash variable style
(block_scalar) @injection.content
  (#match? @injection.content "\\$[A-Za-z_][A-Za-z0-9_]*")
  (#set! injection.language "bash")
