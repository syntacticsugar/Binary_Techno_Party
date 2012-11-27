ENCOG.MathUtil.euclideanDistance = function (a1, a2, startIndex, len) {
    'use strict';

    var result = 0, i, diff;
    for (i = startIndex; i < (startIndex + len); i += 1) {
        diff = a1[i] - a2[i];
        result += diff * diff;
    }
    return Math.sqrt(result);
};
