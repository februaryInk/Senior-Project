function Editor ( controlsHtmlPath, standin ) {
    
    this.$container = $( standin ).parent(  );
    this.controlPanel;
    this.textarea;
    this.uniqueId = Date.now(  );
    
    this.build( controlsHtmlPath, standin );
    this.activateListeners(  );
}

Editor.prototype.activateListeners = function (  ) {
    
    var editor = this;
    
    $( document ).on( 'blur', '.js-editor-textarea-' + this.uniqueId, function(  ) {
        
    } );
    
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
    textareaDiv.className = 'editor-textarea js-editor-textarea-' + this.uniqueId;
    
    this.textarea = new Squire( textareaDiv );
    this.controlPanel = new ControlPanel( this, controlsHtmlPath, controlsDiv );
}
