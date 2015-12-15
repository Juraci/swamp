describe('Highlight', function (){
    var HIGHLIGHT = require('../lib/swamp/js-modules/highlight.js');
    var element;

    it('should set the boxShadow property of the element', function (){
        element = { style: { boxShadow: '' } };
        spyOn(element, 'style');
        HIGHLIGHT.glow(element);
        expect(element.style.boxShadow).toBe('0 0 15px rgba(81, 250, 200, 1)');
    });

    it('should set the border property of the element', function (){
        element = { style: { border: '' } };
        spyOn(element, 'style');
        HIGHLIGHT.glow(element);
        expect(element.style.border).toBe('1px solid rgba(81, 250, 200, 1)');
    });
});
