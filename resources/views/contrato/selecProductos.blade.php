@extends('layout.master')

@section('scripts')

<script src="{{ asset('js/selecProd.js') }}"></script>
@endsection

@section('titulo','Crear Contrato')

@section('contenido')
<div class="container mgt-2">
    <div class="stage tarjeta muli">
        <div>
            <div class="row blocktext">
                <p class="mgt-1" for="empresas"><strong>Empresa con la que se creara un Contrato:</strong></p>
                <div class="dropdown btn-secondary mgl-1">
                    <button class="btn btn-secondary" id="empresa">
                        Empresa
                    </button>
                </div>
            </div>
        </div>
        <form method="POST">
            @csrf
            <div class="mgt-1">
                <div class="row blocktext">
                    <p>Seleccione los Productos que desea incluir en el contrato:</p>
                    <ul>
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle btn btn-secondary">Productos<b class="caret"></b></a>
                        <ul class="dropdown-menu checkbox-menu">
                            <li>
                                <div class="checkbox">
                                    <label>
                                        <input name="productos[]" type="checkbox">Two
                                    </label>
                                </div>
                            </li>
                            <li>
                                <div class="checkbox">
                                    <label>
                                        <input name="productos[]" type="checkbox">Two
                                    </label>
                                </div>
                            </li>
                        </ul>                   
                    </ul>
                </div>
                <div class="row blocktext">
                    <p>Seleccione los Métodos de pago que desea incluir en el Contrato:</p>
                    <ul>
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle btn btn-secondary">Métodos de Pago<b class="caret"></b></a>
                        <ul class="dropdown-menu checkbox-menu">
                            <li>
                                <div class="checkbox">
                                    <label>
                                        <input name="metPago[]" type="checkbox">Two
                                    </label>
                                </div>
                            </li>
                            <li>
                                <div class="checkbox">
                                    <label>
                                        <input name="metPago[]" type="checkbox">Two
                                    </label>
                                </div>
                            </li>
                        </ul>                   
                    </ul>
                </div>
                <div class="row blocktext">
                    <p>Seleccione los Métodos de Envío que desea incluir en el contrato:</p>
                    <ul>
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle btn btn-secondary">Métodos de Envío<b class="caret"></b></a>
                        <ul class="dropdown-menu checkbox-menu">
                            <li>
                                <div class="checkbox">
                                    <label>
                                        <input name="metEnv[]" type="checkbox">Two
                                    </label>
                                </div>
                            </li>
                            <li>
                                <div class="checkbox">
                                    <label>
                                        <input name="metEnv[]" type="checkbox">Two
                                    </label>
                                </div>
                            </li>
                        </ul>                   
                    </ul>
                </div>
                <div class="blocktext row">
                    <p class="exclusividad">Exclusividad
                        <input type="checkbox" id="exclusividad" name="exclusividad">
                    </p>
                </div>
            </div>
            <div class="row blocktext mgt-1 pdb-2">
                    <button type="button" class="btn btn-danger">Cancelar</button>
                    <button type="submit" class="btn btn-primary mgl-1">Crear Contrato</button>
                  </div>
            </div>
        </form>
        </div>
    </div>
</div>
@endsection