var ui, editor;

$( document ).ready( function (  ) {
    if ( $( '.js-squire-standin' ).length ) {
        ui = new Editor(
            '.js-squire-standin',
            '/shared/squire_ui.html'
        );
    }
} );

function Editor ( standin, controlsHtmlPath, config ) {
    
    editor = this;
    
    this.config = {
        buttonStyleClass: 'editor__button',
        controlPanelHandleClass: 'js-control-panel',
        controlPanelStyleClass: 'editor__control-panel',
        dropdownStyleClass: 'editor__dropdown',
        subButtonsContainerStyleClass: 'editor__sub-buttons',
        subButtonStyleClass: 'editor__button',
        textareaHandleClass: 'js-textarea',
        textareaStyleClass: 'editor__textarea'
    }
    
    this.$container = $( standin ).parent(  );
    this.controlPanel;
    this.textarea;
    this.uniqueId = Date.now(  );
    
    this.build( controlsHtmlPath, standin );
    this.activateListeners(  );
}

Editor.prototype.activateListeners = function (  ) {
    
    // TODO: use this.textarea.selector.
    // FIX: blur messes with button-click effects.
    //$( document ).on( 'blur', '.js-editor-textarea-' + this.uniqueId, function(  ) {
    //    editor.controlPanel.neutralizeControlStates(  );
    //} );
    
    $( document ).on( 'click select', '.js-editor-textarea-' + this.uniqueId, function(  ) {
        editor.controlPanel.visualizeControlStates(  );
    } );
    
    $( document ).on( 'keyup', '.js-editor-textarea-' + this.uniqueId, function( event ) {
        var key = event.keyCode || event.which;
        console.log( 'document: ' + event.keyCode || event.which );
        
        if ( key == '37' || key == '38' || key == '39' || key == '40' ) {
            editor.controlPanel.visualizeControlStates(  );
        }
    } );
}

Editor.prototype.build = function ( controlsHtmlPath, standin ) {
    
    var controlsDiv = document.createElement( 'div' );
    var textareaDiv = document.createElement( 'div' );
    
    $( standin ).after( textareaDiv );
    $( standin ).after( controlsDiv );
    $( standin ).remove(  );
    
    controlsDiv.className = 'js-editor-control-panel-' + this.uniqueId;
    textareaDiv.className = this.config.textareaStyleClass + ' ' + this.config.textareaHandleClass + '-' + this.uniqueId;
    
    this.textarea = new Textarea( textareaDiv );
    this.controlPanel = new ControlPanel( controlsHtmlPath, this, controlsDiv );
}
