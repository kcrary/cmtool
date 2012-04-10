
structure MainHs = MainFun (structure Parser = ParserHs
                            structure Codegen = CodegenHs
                            val extension = "hs")
