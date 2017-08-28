syntax keyword  jsImport         import skipwhite skipempty nextgroup=jsModuleAsterisk,jsModuleKeyword,jsModuleGroup,jsFlowImportType conceal cchar=
syntax keyword  jsFrom           contained from skipwhite skipempty nextgroup=jsString conceal cchar=
syntax keyword  jsExportDefault  contained default skipwhite skipempty nextgroup=@jsExpression conceal cchar=
syntax keyword  jsExport         export skipwhite skipempty nextgroup=@jsAll,jsModuleGroup,jsExportDefault,jsModuleAsterisk,jsModuleKeyword,
                                 \jsFlowTypeStatement conceal cchar=
syntax keyword  jsClassKeyword   contained class conceal cchar=
syntax keyword  jsExtendsKeyword contained extends skipwhite skipempty nextgroup=@jsExpression conceal cchar=
syntax match    jsObjectProp     contained /props/ conceal cchar=


syntax match    jsOperator       "&&" conceal cchar=∧
syntax match    jsOperator       /===/ skipwhite skipempty nextgroup=@jsExpression conceal cchar=≡
syntax match    jsOperator       /!==/ skipwhite skipempty nextgroup=@jsExpression conceal cchar=≢
syntax match    jsOperator       /&&/ skipwhite skipempty nextgroup=@jsExpression conceal cchar=∧
syntax match    jsOperator       /||/ skipwhite skipempty nextgroup=@jsExpression conceal cchar=∨
syntax match    jsOperator       "<=" conceal cchar=≤
syntax match    jsOperator       ">=" conceal cchar=≥
syntax match    jsOperator       "!!" conceal cchar=‼
syntax match    jsOperator       "= () =>" conceal cchar=
syntax match    jsOperator       "() =>" conceal cchar=


syntax match    jsxAttrib        /\<style=/ conceal cchar=
syntax match    jsxAttrib        /\<onPress=/ conceal cchar=
syntax match    jsxAttrib        /\<key=/ conceal cchar=
syntax match    jsxAttrib        /\<id=/ conceal cchar=
syntax match    jsxAttrib        /\<ids=/ conceal cchar=
syntax match    jsxAttrib        /\<value=/ conceal cchar=
syntax match    jsxAttrib        /\<data=/ conceal cchar=
syntax match    jsxAttrib        /\<placeholder=/ conceal cchar=▧
syntax match    jsxAttrib        /\<keyboardType=/ conceal cchar=
syntax match    jsxAttrib        /\<update=/ conceal cchar=
syntax match    jsxAttrib        /\<remove=/ conceal cchar=
syntax match    jsxAttrib        /\<select=/ conceal cchar=
syntax match    jsxAttrib        /\<active=/ conceal cchar=⁕
syntax match    jsxAttrib        /\<editing=/ conceal cchar=⁕

let g:javascript_conceal_function             = ""
let g:javascript_conceal_this                 = ""
let g:javascript_conceal_return               = ""
let g:javascript_conceal_super                = ""
let g:javascript_conceal_arrow_function       = ""
