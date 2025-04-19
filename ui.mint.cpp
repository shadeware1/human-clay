s_ 

[3.5] | {
       declare.file(b-h) add+ execution:plus 
}

[4.1] | {
       createNew(window) {
            meta:tag = name("human-clay debloater for Windows 11")
            meta:tag = nameWindow:id(tera)
       }    {
                $get_colors.pkg {
                    set.bg(main) #000000;
                }
       }
}

[4.1] | {   
       block_name:id(logo-display) 
       createNew(wing) {
            $get_grid.pkg {
                    grid setY; setX; use px.dnm 
                    top: 20; - right: 20; - width: 100;(end)
            }
       }
}

[4.1] | {
       block_name:id(content-section) 
       $get_grid.pkg $get_colors.pkg sub.uni
       createNew((sub^1)wing-phs) {
                createNew((b-all)btn) {
                    set.bg(btn) #1a1a1f;
                    set.bd(btn) grid setY; setX; use px.dnm bd: 1; 
                    set.bd(btn-bd) #2c2c36; 
                    set.bn(bn-shd) rgba: 255; 255; 255; -0.05; 
                }
        } {
            set.bn(bn-hv) #2a2a35; 
            makeNew(alt) {
                set.bn(bn-mg) grid setY; setX; use px.dnm bn(W): 64; bn(h): 64; 
            }
        }
}




