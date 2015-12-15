describe('Highlight', function (){
    var HIGHLIGHT = require('../lib/swamp/js-modules/highlight.js');
    var element;

    beforeEach(function (){
        element = { style: {} };
        spyOn(element, 'style');
        HIGHLIGHT.glow(element);
    });

    it('should set the boxShadow property of the element', function (){
        expect(element.style.boxShadow).toBe('0 0 15px rgba(81, 250, 200, 1)');
    });

    it('should set the border property of the element', function (){
        expect(element.style.border).toBe('1px solid rgba(81, 250, 200, 1)');
    });
});
