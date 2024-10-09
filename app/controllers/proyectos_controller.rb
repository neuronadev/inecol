require 'util/email.rb'

class ProyectosController < ApplicationController
  layout :select_layout

  def index
      @total_notifica_rp = 0

      if current_usuario.cuenta.rol.clave == 'EL'
             #@proyectos = Proyecto.includes(etapas: :tevento).order(:created_at).where('teventos.clave':'REV')
             #@proyectos = Proyecto.includes(:dictamen).where.not('dictamenes.numregistro':'DMOD').includes(etapas: :tevento).where('teventos.clave':'REV').order('dictamenes.numregistro')
             @proyectos = Proyecto.includes(:dictamen).includes(etapas: :tevento).where('teventos.clave':'REV').order('dictamenes.numregistro')
             
               puts "----------------------------------"
               puts @proyecto.to_json
      elsif current_usuario.cuenta.rol.clave == 'CAP'
               @proyectos = Proyecto.where(persona_id:current_usuario.cuenta.persona.id).order(:created_at)
               @total_notifica_rp = Proyecto.where(persona_id:current_usuario.cuenta.persona.id).includes(enlaces: :enevento).where('enlaces.estado':'A').where('eneventos.clave':'CORR').count
      elsif current_usuario.cuenta.rol.clave == 'PLAN'
             #@proyectos = Proyecto.includes(enlaces: :enevento).where('eneventos.clave':'DICT')
               @proyectos = Proyecto.includes(:dictamen).includes(enlaces: :enevento).where('eneventos.clave':'FIR').where.not('dictamenes.numregistro':'DMOD').order('dictamenes.numregistro DESC')
      elsif current_usuario.cuenta.rol.clave == 'DIR'
               @proyectos = Proyecto.includes(:dictamen).includes(enlaces: :enevento).where('eneventos.clave':'FIR').order('dictamenes.numregistro')
      elsif current_usuario.cuenta.rol.clave == 'EVAL'
               #@proyectos = Proyecto.includes(validaciones: :tvalidacion).where('tvalidaciones.clave':['SOLV','COM','ACEP','REC']).order(created_at: :desc)
               idevaluador = Evaluador.where(persona_id:current_usuario.cuenta.persona_id).first.id
               @validados = []
               @xevaluarmod = []
               @xevaluar = []
               @xfirmar = []
               Dictamen.where.not(numregistro:'DMOD').order(numregistro: :desc).each do |d|
                    p = Proyecto.find(d.proyecto_id)
                    sig = true
                    tmp_py = p
                     if !Proyecto.where(raiz:tmp_py.id).last.nil?
                                while sig do
                                    if !Proyecto.where(raiz:tmp_py.id).last.nil?           
                                            p_item = Proyecto.find(Proyecto.where(raiz:tmp_py.id).last.id)
                                            enlace_act = p_item.enlaces.order(:created_at).last
                                            
                                            if !enlace_act.blank?
                                                if enlace_act.enevento.clave == 'EVAL'
                                                        if Validacion.where(proyecto_id:p_item.id, evaluador_id:idevaluador).first.nil?
                                                            if !@xevaluarmod.include?(p)
                                                                @xevaluarmod.push(p)
                                                            end   
                                                        else
                                                                @xevaluarmod.push(p)
                                                        end
                                                elsif enlace_act.enevento.clave == 'DICT'
                                                        if Firma.where(proyecto_id:p_item.id, evaluador_id:idevaluador).first.nil?
                                                            if !@xevaluarmod.include?(p)
                                                                @xevaluarmod.push(p)
                                                            end      
                                                        end        
                                                elsif enlace_act.enevento.clave == 'FIR'
                                                        if !@validados.include?(p)
                                                            @validados.push(p)
                                                        end    
                                                end        
                                            else
                                                        if !@validados.include?(p)
                                                             @validados.push(p)    
                                                        end    
                                            end
                                            tmp_py = p_item
                                    else
                                            sig = false
                                    end     
                                end
                     else
                        enlace_valor = p.enlaces.order(:created_at).last
                        if enlace_valor.enevento.clave == 'FIR'
                            if !@validados.include?(p) 
                                @validados.push(p)
                            end     
                        end    
                        if enlace_valor.enevento.clave == 'DICT'
                            if !Firma.where(proyecto_id:p.id, evaluador_id:idevaluador).first.nil?
                                @validados.push(p)
                            end
                        end
                     end
                    #if d.numregistro != 'DMOD'
                    #    @validados.push(d.proyecto)
                    #end
               end
               Proyecto.where(modificatorio:nil).each do |item|
                    enlace_act_v = item.enlaces.order(:created_at).last
                    if !enlace_act_v.blank?
                        if enlace_act_v.enevento.clave == 'EVAL'
                                if Validacion.where(proyecto_id:item.id, evaluador_id:idevaluador).first.nil?
                                     @xevaluar.push(item)
                                else
                                     @xfirmar.push(item)
                                end
                        elsif enlace_act_v.enevento.clave == 'DICT'
                                if Firma.where(proyecto_id:item.id, evaluador_id:idevaluador).first.nil?
                                    @xfirmar.push(item)
                                end
                        end
                        
                    end
               end
      
        
      end

     
  end

  def estadoactual enlace_act
              
  end

  def planconv
      @proyecto = Proyecto.find(params[:id])
  end

  def eplanconv
       @proyecto = Proyecto.find(params[:id])
  end

  def cplanconv
       @proyecto = Proyecto.find(params[:id])
       @proyecto.planconv = params[:planconv]
       respond_to do |format|
           if @proyecto.save
                 format.html { redirect_to planconv_proyecto_path(@proyecto) }
           else
                 format.html { render :planconv, status: :bad_request }
           end
      end
  end

  def finalizar
      @proyecto = Proyecto.find(params[:id])
  end

  def sfinalizar
      @proyecto = Proyecto.find(params[:id])
  end

  def cfinalizar
       @proyecto = Proyecto.find(params[:id])
       tevento = Tevento.where(clave:'FIN').first
       @proyecto.txtlogro = params[:txtlogro]
       @proyecto.dfiniquito = params[:dfiniquito]

       respond_to do |format|
           if @proyecto.save
                 Etapa.create!(proyecto_id:@proyecto.id, tevento_id:tevento.id)
                 format.html { redirect_to sfinalizar_proyecto_path(@proyecto) }
           else
                 format.html { render :planconv, status: :bad_request }
           end
       end
  end
   


  def show
    
      @proyecto = Proyecto.find(params[:id])
       respond_to do |format|
            format.html
            format.pdf do
                render pdf: "Ficha #{@proyecto.id}",
                page_size: 'A4',
                template: "proyectos/show",
                layout: "pdf",
                #orientation: "Portrait",
                orientation: "Landscape",
                lowquality: false,
                encoding: 'UTF-8',
                zoom: 1,
                dpi: 75
            end
        end
  end

  def new
      session[:proyecto_id] = nil
      session[:step] = 0
      @proyecto = Proyecto.new
      @proyecto.instituciones.build
      @proyecto.build_mconvocatoria
      #@proyecto.build_protocolo
      #@proyecto.build_convenio
     
  end

  def create
      @proyecto = Proyecto.new(proyecto_params)
      respond_to do |format|
            if @proyecto.save
                   tevento = Tevento.where(clave:'CAP').first
                   Etapa.create!(proyecto_id:@proyecto.id, tevento_id:tevento.id)
                   session[:proyecto_id] = @proyecto.id
                   session[:step] = 1
                   #format.html { redirect_to new_fuente_path } <---NOOOOOO
                   format.html { redirect_to @proyecto } 
            else
                    @proyecto.build_mconvocatoria(nomconvocatoria:params[:proyecto][:mconvocatoria_attributes][:nomconvocatoria],
                                                  link:params[:proyecto][:mconvocatoria_attributes][:link])
                    flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                    format.html { render :new, status: :bad_request }
            end
      end
  end

  def edit
      @proyecto = Proyecto.find(params[:id])
      if @proyecto.mconvocatoria.nil?
           @proyecto.build_mconvocatoria
      end
      
  end

  def update
      @proyecto = Proyecto.find(params[:id]) 
      @proyecto.update(proyecto_params)
      respond_to do |format|
           if @proyecto.save
               #format.html { redirect_to proyecto_path(@proyecto) }
                  if (current_usuario.cuenta.rol.clave == 'EL' || current_usuario.cuenta.rol.clave == 'EVAL' ) && params[:el_prot] == 'elprot_edit'
                        format.html {render 'documentos/protocolo'}
                  elsif current_usuario.cuenta.rol.clave == 'EL' && params[:el_odoc] == 'elodoc_edit'
                        format.html {render 'documentos/convenio'}
                  else
                        format.html { redirect_to proyecto_path(@proyecto) }
                  end
           else
               format.html { render :edit, status: :bad_request }
           end
      end

  end

  def continuar
       @p = Proyecto.find(params[:idp]) 
       session[:proyecto_id] = @p.id
       session[:step] = @p.cap_paso
       redirect_to action:"show", id:@p
  end

  def observa
      @proyecto = Proyecto.find(params[:id]) 
  end

  def atendida
        @proyecto = Proyecto.find(params[:id]) 
        
  end

  def institucion
      @idx = (Time.now.to_f*1000.0).to_i
      respond_to do |format|
             format.html { render partial: 'fields_institucion'}
      end 
  end
  def tipomedio
      medio = Medio.find(params[:medio_id])
      data = {clave:medio.clave}
      respond_to do |format|
          format.json { render json:data.to_json }
      end
  end

  def tipoclasifica
      clasifica = Clasificacion.find(params[:clasifica_id])
      data = { clave:clasifica.clave, ovh:clasifica.ovh }
      respond_to do |format|
        format.json { render json:data.to_json }
      end
  end
  def medclave
       medio = Medio.where(clave:params[:clave_medio]).first
       data = {medio_id:medio.id}
       respond_to do |format|
        format.json { render json:data.to_json }
      end
  end

  def enviar
       proyecto = Proyecto.find(params[:id])

       evento = Tevento.where(clave:'REV').first
       Etapa.create!(proyecto_id:proyecto.id, tevento_id:evento.id)

       enevento = Enevento.where(clave:'NVO').first
       Enlace.create!(proyecto_id:proyecto.id, enevento_id:enevento.id)
              
       Util::Email.notificar(proyecto.id, 'RPEN')

       respond_to do |format|
           format.json { render json:proyecto.to_json }
       end
  end

  def seguimiento
       proyecto = Proyecto.find(params[:id])
       tipo = params[:tipo]

       proyecto.seguimiento = tipo
       proyecto.save

       respond_to do |format|
           format.json { render json:proyecto.to_json }
       end
  end
 
  def eliminar
       proyecto = Proyecto.find(params[:id])
       evento = Tevento.where(clave:'DEL').first
       Etapa.create!(proyecto_id:proyecto.id, tevento_id:evento.id)
       respond_to do |format|
           format.json { render json:@proyecto.to_json }
       end
  end

  def documento
      @tipo = Proyecto.find(params[:tipo])
      proyecto = Proyecto.find(params[:idpy])

  end

  def nombrecorto
    proyecto = Proyecto.find(params[:idproy].to_i)
    periodo = Periodo.where(anio:2024).first

    if proyecto.enlaces.last.enevento.clave == 'FIR'
          sc = proyecto.dictamen.numregistro + '-' + proyecto.persona.nom_espacio
          r = {'nombre':sc, 'link': resumen_vistas_path(:id=>proyecto.id) }
          Item.create!(periodo_id:periodo.id, nombre:sc, proyecto_id:proyecto.id, orden:Item.count()+1)
    else
          r = {'nombre':0}
    end
    
    respond_to do |format|
        format.json { render json:r.to_json}
    end
  end

  def cambiarnm
      nombre = params[:nombre]
      id = params[:item]

      #item = Item.find(id)
      item = Item.where(proyecto_id: id).first
      item.nombre = nombre
      item.save

      r = {'result':'ok'}
      
      respond_to do |format|
           format.json { render json:r.to_json}
      end
  end

  def moveritem
      py = Proyecto.find(params[:idproy].to_i)
      loop do
          if py.modificatorio.nil?
               break
          end
          py = Proyecto.find(py.raiz)
      end 
      item_py = Item.where(proyecto_id: py.id).first
      item_py.delete

      r = {'result':'ok'}
      respond_to do |format|
           format.json { render json:r.to_json}
      end

  end

  

  private
  def proyecto_params
      params.require(:proyecto).permit(:nombre, 
                                       :objetivo,
                                       :clasificacion_id,
                                       :overhead,
                                       :medio_id,
                                       :linea_id,
                                       :periodo,
                                       :tfconoc,
                                       :interinst,
                                       :persona_id,
                                       :dconvocatoria,
                                       docconvenios:[],
                                       docprotocolos:[],
                                       mconvocatoria_attributes:[:id, :nomconvocatoria, :link, :_destroy],
                                       instituciones_attributes:[:id, :nominstitucion, :_destroy]
                                       #protocolo_attributes:[:id, :dprotocolo, :activo],
                                       #convenio_attributes:[:id, :dconvenio, :activo]
                                      
                                    )
  end
 
  protected 
     def select_layout
        
        if !current_usuario.nil?
             if current_usuario.cuenta.rol.clave == 'EL'
                   return 'enlaces' 
             elsif current_usuario.cuenta.rol.clave == 'EVAL'
                   return 'validaciones'
             elsif current_usuario.cuenta.rol.clave == 'PLAN'
                   return 'planeacion'
             elsif current_usuario.cuenta.rol.clave == 'DIR'
                    return 'direccion'
             else
                   return 'proyectos'
             end
                
        end

    end        

end
