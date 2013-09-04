#ifndef NRPSDESIGNER_DOMAINTYPET_H
#define NRPSDESIGNER_DOMAINTYPET_H

#include "nrpsdesigner_export.h"
#include "global_enums.h"
#include "domain.h"

namespace nrps
{
class DomainTypeT : public Domain
{
public:
    DomainTypeT(uint32_t);
    DomainTypeT(uint32_t, DomainTPosition);
    virtual ~DomainTypeT();
    
    DomainTPosition position() const;
    void setPosition(DomainTPosition);

protected:
    virtual void writeXml(xmlTextWriterPtr) const;
    
private:
    DomainTPosition m_position;
};
}

#endif
