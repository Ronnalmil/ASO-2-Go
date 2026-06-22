$nombre=read-host "nombre del nuevo usuario"
$pass=read-host "contraseña del usuario"
$pass=ConvertTo-SecureString $pass -AsPlainText -Force

$respuesta=read-host "señor usuario quiere informarlo s/n"
if ( $respuesta -eq "s" ){
    $datos= @{
       "accountexpires"=@("Desea que su cuenta expire s/n",$null)   
       "descripcion"=@("descripcion s/n",$null)
       "disabled"=@("quiere deshabilitar su cuenta s/n",$null)
       "fullname"=@("fullname s/n",$null)
    }
      foreach( $run in $datos.keys ){
             write-host $run vamoos
         if( $run -eq "disabled" ){
             $pregunta=$datos[$run][0] 
             $respuesta=Read-Host "$pregunta"
             if( $respuesta -eq "n" ){
                                     Write-Host "ha constestado no...."
                                     $cuenta="n"
                                     $datos[$run][1]="enabled"

             }
             else{
             $datos[$run][1]="disabled"
             write-host "esta cuenta se ha deshabilitado...pronto"
             $cuenta="s"
             }
          
          }
          elseif( $run -eq "accountexpires" ){
               $pregunta=$datos[$run][0]
               $respuesta=read-host "$pregunta"
               if( $respuesta -eq "n" ){
                                        Write-Host "saliendo...accountexpires..."
                                        continue
               }
               else{
               $fecha=Read-Host "diga la fecha: (año-mes-dia)"
               $datos[$run][1]=$fecha
               Write-Host "su cuenta tiene fecha de expiración..."
               $expirar=get-date "$fecha"
               }
                                                     
          }
          elseif( $run -eq "descripcion" ){
             $pregunta=$datos[$run][0] 
             $respuesta=Read-Host "$pregunta"
             if( $respuesta -eq "n" ){
                                     write-host "saliendo..descripcion.."
                                     continue
             }
             else{
             $respuesta=read-host "añada descripcion:"
             $datos[$run][1]=$respuesta
             write-host "añadiendo descripcion..."
             }

          }
          elseif( $run -eq "fullname" ){
             $pregunta=$datos[$run][0] 
             $respuesta=Read-Host "$pregunta"
             if( $respuesta -eq "n" ){
                                     write-host "saliendo de fullname...."
                                     continue
             }
             else{
             $respuesta=read-host "añada fullname:"
             $datos[$run][1]=$respuesta
             write-host "añadiendo fullname..."
             }
          }
     
          
         
      }
}
Write-Host "COMIENZA...........creando usuario"
New-LocalUser $nombre -Password $pass -Description $datos["descripcion"][1] -FullName $datos["fullname"][1] -AccountExpires $datos["accountexpires"][1] 

if( $cuenta -eq "s" ){
    Disable-LocalUser $nombre
}elseif( $cuenta -eq "n" ){
    Enable-LocalUser $nombre
}

Write-Host "fininito....creando usuario: $nombre"
#New-LocalUser $nombre -Password $pass -Description "el cazador" -FullName "" -Disabled -AccountExpires
# Funciona ok ok , pregunta a ainhoa envialo que opina, tendriamos que comparar con el dos de ainhoa 
