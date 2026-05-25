% ===== KOA Combined Output | contract_id: contrato_ocs_042_2021 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_042_2021_-_TIVIT_(Data_Center_Alternativo).pl
% contract_id: contrato_ocs_042_2021

instance_of(contrato_ocs_042_2021, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_042_2021).
plays_role(tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, hired_service_provider_role, contrato_ocs_042_2021).

clause_of(clausula_primeira_objeto, contrato_ocs_042_2021).
clause_of(clausula_segunda_vigencia, contrato_ocs_042_2021).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_042_2021).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_042_2021).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_042_2021).
clause_of(clausula_sexta_preco, contrato_ocs_042_2021).
clause_of(clausula_setima_pagamento, contrato_ocs_042_2021).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_042_2021).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_042_2021).
clause_of(clausula_decima_segunda_conduta_etica_contratada_bndes, contrato_ocs_042_2021).
clause_of(clausula_decima_terceira_sigilo_informacoes, contrato_ocs_042_2021).
clause_of(clausula_decima_quarta_obrigações_bndes, contrato_ocs_042_2021).
clause_of(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, contrato_ocs_042_2021).
clause_of(clausula_decima_sexta_penalidades, contrato_ocs_042_2021).
clause_of(clausula_decima_setima_alterações_contratuais, contrato_ocs_042_2021).
clause_of(clausula_decima_oitava_extinção_contrato, contrato_ocs_042_2021).
clause_of(clausula_decima_nona_disposições_finais, contrato_ocs_042_2021).
clause_of(clausula_vigésima_foro, contrato_ocs_042_2021).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_042_2021).
clause_of(clausula_decima_primeira_obrigacoes_contratada, contrato_ocs_042_2021).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, provide_data_center_infrastructure).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_data_center_infrastructure).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, provide_datacenter_service).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_datacenter_service).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, execute_service_according_to_proposal).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, execute_service_according_to_reference_term).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_service_according_to_proposal).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_service_according_to_reference_term).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, execute_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, price_reduction_due_to_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, stipulate_service_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, penalties_for_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_receipt_of_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_receipt_of_object).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_preco, right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, bear_costs_of_errors).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, demand_indemnification).
legal_relation_instance(clausula_sexta_preco, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, be_subject_to_reduced_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bndes_effect_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, contracted_party_present_invoice).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, contracted_party_provide_fiscal_docs).
legal_relation_instance(clausula_setima_pagamento, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bndes_not_pay_subcontractor).
legal_relation_instance(clausula_setima_pagamento, right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, contracted_party_receive_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bndes_deduct_values).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bndes_pay_interest).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, negotiate_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, present_information_for_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, request_price_adjustment_revision_before_contract_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_readjustment_revision_request).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_omission, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, not_request_price_adjustment_revision).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, application_of_penalty).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, complement_or_replace_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, maintain_integrity_in_public_private_relations).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity_in_public_private_relations).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, act_in_good_faith).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, act_in_good_faith).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, base_conduct_on_ethical_precepts).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, base_conduct_on_ethical_precepts).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, prevent_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, ensure_no_family_allocation).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, observe_bndes_ethics_code).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, comply_with_bndes_security_policy).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, not_access_confidential_info_without_auth).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, limit_access_to_info).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, report_security_breaches).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, return_bndes_property).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, not_use_confidential_info_post_contract).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, observe_confidentiality_term).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contratada).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_ethics_code_copy).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_irregularity_investigation).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_quarta_obrigações_bndes, right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, assign_contract_or_credit).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_omit, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, issue_credit_title).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, no_right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, contractual_succession).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_or_damages).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, maintain_contractual_conditions).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_or_damages_of_subcontracting).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, remain_responsible_for_execution).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, present_confidentiality_terms).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, permission_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, merger_spin_off_or_incorporation).
legal_relation_instance(clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, duty_to_act, unknown, assume_position_of_successor).
legal_relation_instance(clausula_decima_sexta_penalidades, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, be_subject_to_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, appeal_penalty_decision).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_multas_from_credits).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, present_defense).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, charge_judicially).
legal_relation_instance(clausula_decima_sexta_penalidades, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, ensure_due_process).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_damages_for_refusal).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_amendment).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, answer_for_damages).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_contract_amendment).
legal_relation_instance(clausula_decima_oitava_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notification).
legal_relation_instance(clausula_decima_oitava_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_for_defense).
legal_relation_instance(clausula_decima_oitava_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_execution).
legal_relation_instance(clausula_decima_oitava_extinção_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_extinção_contrato, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, subjection_to_contract_termination).
legal_relation_instance(clausula_decima_oitava_extinção_contrato, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, subjection_to_loss_of_habilitation).
legal_relation_instance(clausula_decima_oitava_extinção_contrato, subjection, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, subjection_to_being_declared_inidonea).
legal_relation_instance(clausula_decima_nona_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_at_any_time).
legal_relation_instance(clausula_decima_nona_disposições_finais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, strictly_comply_with_contract_obligations).
legal_relation_instance(clausula_decima_nona_disposições_finais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_renouncing_rights).
legal_relation_instance(clausula_vigésima_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_rio_de_janeiro_forum).
legal_relation_instance(clausula_vigésima_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_another_forum).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, not_create_additives_for_allocated_risks).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_additives_for_allocated_risks).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, respect_economic_financial_equilibrium_clause).
legal_relation_instance(clausula_nona_matriz_riscos, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_respect_economic_financial_equilibrium_clause).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, send_and_keep_updated_list_to_bndes).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, promptly_meet_any_requirements_of_bndes).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, provide_all_clarifications_requested_by_bndes).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, identify_professionals_with_company_badges).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, adopt_appropriate_security_measures).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, limit_access_to_information).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_omit, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, not_use_copy_duplicate_or_reproduce_bndes_info).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_omit, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, not_reverse_compile_or_engineer).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, ensure_awareness_of_confidentiality).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, tivit_terceirizacao_de_processos_servicos_e_tecnologia_s_a, return_identification_badges).

% --- Action catalog (local to this contract grounding) ---
action_type(act_in_good_faith).
action_label(act_in_good_faith, 'Act in good faith').
action_type(adopt_appropriate_security_measures).
action_label(adopt_appropriate_security_measures, 'Adopt security measures').
action_type(adopt_good_environmental_practices).
action_label(adopt_good_environmental_practices, 'Adopt environmental practices').
action_type(agree_to_contract_amendment).
action_label(agree_to_contract_amendment, 'Agree to amendment').
action_type(allow_access_to_terms_documents_information).
action_label(allow_access_to_terms_documents_information, 'Allow access to information').
action_type(allow_inspections_monitoring).
action_label(allow_inspections_monitoring, 'Allow inspections').
action_type(alter_contract_manager).
action_label(alter_contract_manager, 'Alter contract manager').
action_type(analyze_readjustment_revision_request).
action_label(analyze_readjustment_revision_request, 'Analyze adjustment/revision request').
action_type(analyze_risks_or_damages).
action_label(analyze_risks_or_damages, 'Analyze risks/damages').
action_type(analyze_risks_or_damages_of_subcontracting).
action_label(analyze_risks_or_damages_of_subcontracting, 'Analyze risks of subcontracting').
action_type(answer_for_damages).
action_label(answer_for_damages, 'Answer for damages').
action_type(appeal_penalty_decision).
action_label(appeal_penalty_decision, 'Appeal penalty decision').
action_type(application_of_penalty).
action_label(application_of_penalty, 'Subject to penalty').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction).
action_label(apply_price_reduction, 'Apply price reduction').
action_type(assign_contract_or_credit).
action_label(assign_contract_or_credit, 'No right to assign contract').
action_type(assume_position_of_successor).
action_label(assume_position_of_successor, 'Assume position of successor').
action_type(attend_to_transition_requests).
action_label(attend_to_transition_requests, 'Attend to transition').
action_type(base_conduct_on_ethical_precepts).
action_label(base_conduct_on_ethical_precepts, 'Base conduct on ethics').
action_type(be_responsible_for_compliance_with_safety_standards).
action_label(be_responsible_for_compliance_with_safety_standards, 'Responsible for safety').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_reduced_payment).
action_label(be_subject_to_reduced_payment, 'Subject to reduced payment').
action_type(bear_costs_of_errors).
action_label(bear_costs_of_errors, 'Bear cost of proposal errors').
action_type(bndes_deduct_values).
action_label(bndes_deduct_values, 'Deduct amounts owed').
action_type(bndes_effect_payment).
action_label(bndes_effect_payment, 'BNDES must make payment').
action_type(bndes_not_pay_subcontractor).
action_label(bndes_not_pay_subcontractor, 'Do not pay subcontractor').
action_type(bndes_pay_interest).
action_label(bndes_pay_interest, 'Pay interest on late payments').
action_type(charge_judicially).
action_label(charge_judicially, 'Charge judicially').
action_type(choose_another_forum).
action_label(choose_another_forum, 'Choose another forum').
action_type(choose_rio_de_janeiro_forum).
action_label(choose_rio_de_janeiro_forum, 'Choose Rio de Janeiro forum').
action_type(claim_damages_for_refusal).
action_label(claim_damages_for_refusal, 'Claim damages for refusal').
action_type(communicate_imposition_of_penalty).
action_label(communicate_imposition_of_penalty, 'Communicate penalty').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_irregularity_investigation).
action_label(communicate_irregularity_investigation, 'Communicate irregularity investigation').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(complement_or_replace_guarantee).
action_label(complement_or_replace_guarantee, 'Complement/replace guarantee').
action_type(comply_with_bndes_security_policy).
action_label(comply_with_bndes_security_policy, 'Comply with BNDES security policy').
action_type(contracted_party_present_invoice).
action_label(contracted_party_present_invoice, 'Present invoice').
action_type(contracted_party_provide_fiscal_docs).
action_label(contracted_party_provide_fiscal_docs, 'Provide fiscal documents').
action_type(contracted_party_receive_payment).
action_label(contracted_party_receive_payment, 'Right to receive payment').
action_type(contractual_succession).
action_label(contractual_succession, 'No right to contractual succession').
action_type(deduct_multas_from_credits).
action_label(deduct_multas_from_credits, 'Deduct from credits').
action_type(demand_additives_for_allocated_risks).
action_label(demand_additives_for_allocated_risks, 'No right to demand additives for allocated risks').
action_type(demand_indemnification).
action_label(demand_indemnification, 'No right to demand indemnification').
action_type(demand_respect_economic_financial_equilibrium_clause).
action_label(demand_respect_economic_financial_equilibrium_clause, 'Demand respect for equilibrium clause').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(effect_receipt_of_object).
action_label(effect_receipt_of_object, 'Effect receipt of object').
action_type(ensure_awareness_of_confidentiality).
action_label(ensure_awareness_of_confidentiality, 'Ensure awareness of confidentiality').
action_type(ensure_due_process).
action_label(ensure_due_process, 'Ensure due process').
action_type(ensure_no_family_allocation).
action_label(ensure_no_family_allocation, 'Ensure no family allocation').
action_type(execute_service_according_to_proposal).
action_label(execute_service_according_to_proposal, 'Execute service per proposal').
action_type(execute_service_according_to_reference_term).
action_label(execute_service_according_to_reference_term, 'Execute service per reference term').
action_type(execute_service_according_to_standards).
action_label(execute_service_according_to_standards, 'Execute service according to standards').
action_type(exercise_rights_at_any_time).
action_label(exercise_rights_at_any_time, 'Exercise rights').
action_type(expect_service_according_to_proposal).
action_label(expect_service_according_to_proposal, 'Expect service per proposal').
action_type(expect_service_according_to_reference_term).
action_label(expect_service_according_to_reference_term, 'Expect service per reference term').
action_type(formalize_contract_amendment).
action_label(formalize_contract_amendment, 'Formalize amendment').
action_type(guarantee_non_infringement_of_rights).
action_label(guarantee_non_infringement_of_rights, 'Guarantee non-infringement').
action_type(identify_professionals_with_company_badges).
action_label(identify_professionals_with_company_badges, 'Identify professionals').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Initiate price revision').
action_type(issue_credit_title).
action_label(issue_credit_title, 'Duty not to issue credit title').
action_type(limit_access_to_info).
action_label(limit_access_to_info, 'Limit access to confidential information').
action_type(limit_access_to_information).
action_label(limit_access_to_information, 'Limit access to information').
action_type(maintain_complete_and_absolute_secrecy).
action_label(maintain_complete_and_absolute_secrecy, 'Maintain secrecy').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality of BNDES information').
action_type(maintain_contractual_conditions).
action_label(maintain_contractual_conditions, 'Maintain contract conditions').
action_type(maintain_integrity_in_public_private_relations).
action_label(maintain_integrity_in_public_private_relations, 'Maintain integrity in public relations').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification').
action_type(make_payments_to_contratada).
action_label(make_payments_to_contratada, 'Make payments').
action_type(merger_spin_off_or_incorporation).
action_label(merger_spin_off_or_incorporation, 'Permitted corporate operations').
action_type(negotiate_price_reduction).
action_label(negotiate_price_reduction, 'Negotiate price reduction').
action_type(not_access_confidential_info_without_auth).
action_label(not_access_confidential_info_without_auth, 'Not access confidential info without authorization').
action_type(not_create_additives_for_allocated_risks).
action_label(not_create_additives_for_allocated_risks, 'Do not create additives for allocated risks').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_request_price_adjustment_revision).
action_label(not_request_price_adjustment_revision, 'Not request price adjustment/revision').
action_type(not_reverse_compile_or_engineer).
action_label(not_reverse_compile_or_engineer, 'Do not reverse engineer').
action_type(not_use_confidential_info_post_contract).
action_label(not_use_confidential_info_post_contract, 'Not use confidential information after contract').
action_type(not_use_copy_duplicate_or_reproduce_bndes_info).
action_label(not_use_copy_duplicate_or_reproduce_bndes_info, 'Do not use/copy BNDES info').
action_type(obey_instructions_procedures).
action_label(obey_instructions_procedures, 'Obey instructions').
action_type(observe_bndes_ethics_code).
action_label(observe_bndes_ethics_code, 'Observe BNDES ethics code').
action_type(observe_confidentiality_term).
action_label(observe_confidentiality_term, 'Observe confidentiality term').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor\'s consent').
action_type(omit_renouncing_rights).
action_label(omit_renouncing_rights, 'Omit renouncing rights').
action_type(pay_charges_taxes).
action_label(pay_charges_taxes, 'Pay charges, taxes').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay the contracted party').
action_type(penalties_for_non_compliance).
action_label(penalties_for_non_compliance, 'Subject to penalties').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_defense).
action_label(present_defense, 'Present defense').
action_type(present_information_for_price_reduction).
action_label(present_information_for_price_reduction, 'Present information for price reduction').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(price_reduction_due_to_non_compliance).
action_label(price_reduction_due_to_non_compliance, 'Subject to price reduction').
action_type(promptly_meet_any_requirements_of_bndes).
action_label(promptly_meet_any_requirements_of_bndes, 'Meet BNDES requirements').
action_type(provide_all_clarifications_requested_by_bndes).
action_label(provide_all_clarifications_requested_by_bndes, 'Provide clarifications').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_data_center_infrastructure).
action_label(provide_data_center_infrastructure, 'Provide data center infrastructure').
action_type(provide_datacenter_service).
action_label(provide_datacenter_service, 'Provide datacenter service').
action_type(provide_ethics_code_copy).
action_label(provide_ethics_code_copy, 'Provide ethics code copy').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_opportunity_for_defense).
action_label(provide_opportunity_for_defense, 'Provide opportunity for defense').
action_type(provide_proof_of_exclusion_from_simples_nacional).
action_label(provide_proof_of_exclusion_from_simples_nacional, 'Prove exclusion from Simples').
action_type(provide_written_notification).
action_label(provide_written_notification, 'Provide written notification').
action_type(receive_data_center_infrastructure).
action_label(receive_data_center_infrastructure, 'Receive data center infrastructure').
action_type(receive_datacenter_service).
action_label(receive_datacenter_service, 'Receive datacenter service').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive Payments').
action_type(remain_responsible_for_execution).
action_label(remain_responsible_for_execution, 'Responsible for contract execution').
action_type(repair_correct_remove_reconstruct_or_replace).
action_label(repair_correct_remove_reconstruct_or_replace, 'Repair, correct, etc.').
action_type(repair_damages_losses).
action_label(repair_damages_losses, 'Repair damages').
action_type(report_any_irregularity_observed).
action_label(report_any_irregularity_observed, 'Report irregularities').
action_type(report_security_breaches).
action_label(report_security_breaches, 'Report security breaches').
action_type(request_price_adjustment_revision_before_contract_end).
action_label(request_price_adjustment_revision_before_contract_end, 'Request adjustment/revision before end').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Request price readjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(respect_economic_financial_equilibrium_clause).
action_label(respect_economic_financial_equilibrium_clause, 'Respect equilibrium clause').
action_type(return_bndes_property).
action_label(return_bndes_property, 'Return BNDES property at contract end').
action_type(return_funds_revoke_access_profiles_remove_mailboxes).
action_label(return_funds_revoke_access_profiles_remove_mailboxes, 'Return funds, revoke access').
action_type(return_identification_badges).
action_label(return_identification_badges, 'Return ID badges').
action_type(send_and_keep_updated_list_to_bndes).
action_label(send_and_keep_updated_list_to_bndes, 'Send and update list to BNDES').
action_type(stipulate_service_standards).
action_label(stipulate_service_standards, 'Stipulate service standards').
action_type(strictly_comply_with_contract_obligations).
action_label(strictly_comply_with_contract_obligations, 'Strictly comply with obligations').
action_type(subcontract_part_of_object).
action_label(subcontract_part_of_object, 'Permitted to subcontract').
action_type(subject_to_penalties).
action_label(subject_to_penalties, 'Subject to penalties').
action_type(subjection_to_being_declared_inidonea).
action_label(subjection_to_being_declared_inidonea, 'Subject to being declared inidonea').
action_type(subjection_to_contract_termination).
action_label(subjection_to_contract_termination, 'Subject to termination').
action_type(subjection_to_loss_of_habilitation).
action_label(subjection_to_loss_of_habilitation, 'Subject to loss of habilition').
action_type(suspend_execution).
action_label(suspend_execution, 'Suspend contract execution').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_042_2021).
contract_metadata(contrato_ocs_042_2021, numero_ocs, '042/2021').
contract_metadata(contrato_ocs_042_2021, numero_sap, '4400004554').
contract_metadata(contrato_ocs_042_2021, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇO').
contract_metadata(contrato_ocs_042_2021, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'TIVIT TERCEIRIZACAO DE PROCESSOS SERVIÇOS E TECNOLOGIA S/A']).
contract_metadata(contrato_ocs_042_2021, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_042_2021, contratado, 'TIVIT TERCEIRIZACAO DE PROCESSOS SERVIÇOS E TECNOLOGIA S/A').
contract_metadata(contrato_ocs_042_2021, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_042_2021, cnpj_contratado, '07.073.027/0001-53').
contract_metadata(contrato_ocs_042_2021, procedimento_licitatorio, 'Pregão Eletrônico nº 55/2020').
contract_metadata(contrato_ocs_042_2021, data_autorizacao, '17/12/2020').
contract_metadata_raw(contrato_ocs_042_2021, ip_ati_deset, '038/2020', 'trecho_literal').
contract_metadata(contrato_ocs_042_2021, rubrica_orcamentaria, '3101700090').
contract_metadata(contrato_ocs_042_2021, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_042_2021, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata_raw(contrato_ocs_042_2021, regulamento, 'Regulamento de Formalização, Execução e Fiscalização dos Contratos Administrativos do Sistema BNDES', 'trecho_literal').
contract_clause(contrato_ocs_042_2021, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a contratação de serviços de disponibilização de infraestrutura de data center alternativo do BNDES, conforme especificações constantes do Termo de Referência e da Proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_042_2021, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração:   a. até 90 (noventa) dias corridos, a contar da assinatura do Contrato, para disponibilização do serviço de datacenter alternativo, encerrando-se com a emissão do Termo de Recebimento Definitivo da Implantação do Serviço;  b. 60 (sessenta) meses contados a partir do Termo de Recebimento Definitivo da Implantação do Serviço, para a efetiva prestação do serviço de disponibilização do DC alternativo.').
contract_clause(contrato_ocs_042_2021, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do serviço respeitará as especificações constantes da Proposta apresentada pela CONTRATADA e do Termo de Referência, respectivamente, Anexos II e I deste Contrato.').
contract_clause(contrato_ocs_042_2021, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'O serviço contratado deverá ser executado de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, segundo as metas de nível de serviço descritas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Único O descumprimento de qualquer meta de nível de serviço pactuada acarretará a aplicação de índice de redução do preço previsto no Termo de Referência, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_042_2021, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Termo de Referência (Anexo I deste Contrato).').
contract_clause(contrato_ocs_042_2021, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará à CONTRATADA, pela execução do objeto contratado, o valor de até R$ 32.877.000,00 (Trinta e dois milhões e oitocentos e setenta e sete mil reais), conforme Proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento, e a seguinte composição:     Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização à CONTRATADA.   Parágrafo Quarto A CONTRATADA deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua Proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua Proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_042_2021, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, observado o disposto no Anexo I (Termo de Referência), por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pela CONTRATADA.   Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES.  Parágrafo Segundo Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.   Parágrafo Terceiro Para toda efetivação de pagamento, a CONTRATADA deverá encaminhar 1 (uma) via do documento fiscal ou equivalente legal ao sistema de captação de notas fiscais eletrônicas do BNDES, ou, quando emitido em papel, ao Protocolo do Edifício de Serviços do BNDES no Rio de Janeiro - EDSERJ, localizado na Avenida República do Chile nº 100, Térreo, Centro, Rio de Janeiro, CEP nº 20.031-917, no período compreendido entre 10h e 18h.  Parágrafo Quarto O BNDES não efetuará pagamento diretamente em favor da(s) SUBCONTRATADA(S).     Parágrafo Quinto  O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato  V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ da CONTRATADA, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador dos serviços: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador dos serviços: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso; e  XIII. código dos serviços, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento.  Parágrafo Sexto O documento fiscal ou equivalente legal emitido pela CONTRATADA deverá estar em conformidade com a legislação do Município onde a CONTRATADA esteja estabelecido, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos federais, sob pena de devolução do documento e interrupção do prazo para pagamento.  Parágrafo Sétimo  Caso a CONTRATADA emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser  suportado pela CONTRATADA, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Oitavo Ao documento fiscal ou equivalente legal deverão ser anexados:  I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado; e V. comprovante de que a CONTRATADA recolheu para o Regime Geral de Previdência Social, no mês respectivo, sobre o limite máximo do salário-de-contribuição ou em valor inferior, se for o caso.  Parágrafo Nono Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal à CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.  Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_042_2021, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pela CONTRATADA a cada período de 12 (doze) meses, sendo o primeiro contado do dia 09/02/2021, data limite para a apresentação da Proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação - ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA acumulado, sobre o preço referido na Cláusula de Preço deste Instrumento.   Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação da CONTRATADA, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado à CONTRATADA nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a CONTRATADA deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da Proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, a CONTRATADA deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da Proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar a CONTRATADA para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na Proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo à CONTRATADA apresentar as informações solicitadas pelo BNDES.    Parágrafo Quarto A CONTRATADA deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pela CONTRATADA dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto a CONTRATADA não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso a CONTRATADA não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.', 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pela CONTRATADA a cada período de 12 (doze) meses, sendo o primeiro contado do dia 09/02/2021, data limite para a apresentação da Proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação - ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA acumulado, sobre o preço referido na Cláusula de Preço deste Instrumento.   Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação da CONTRATADA, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado à CONTRATADA nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a CONTRATADA deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da Proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, a CONTRATADA deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da Proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar a CONTRATADA para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na Proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo à CONTRATADA apresentar as informações solicitadas pelo BNDES.    Parágrafo Quarto A CONTRATADA deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pela CONTRATADA dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto a CONTRATADA não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso a CONTRATADA não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.').
contract_clause(contrato_ocs_042_2021, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e a CONTRATADA, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_042_2021, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL A CONTRATADA prestará garantia contratual, no prazo de até 10 (dez) dias úteis, contados da convocação, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para a sua aceitação estipuladas nos incisos abaixo, no valor de R$ 1.643.850,00 (um milhão, seiscentos e quarenta e três mil e oitocentos e cinquenta reais), correspondente a 5 % (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas por este; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a)  O Instrumento de Apólice de Seguro deve prever expressamente: 1. responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas à CONTRATADA; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a)  O Instrumento de Fiança deve prever expressamente: 1. renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.      Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pela CONTRATADA durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.   Parágrafo Segundo Em caso de alteração do valor contratual, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, a CONTRATADA deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, a CONTRATADA deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe à CONTRATADA obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.  Parágrafo Quarto No caso de Consórcio, somente será aceita uma única garantia.', 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL A CONTRATADA prestará garantia contratual, no prazo de até 10 (dez) dias úteis, contados da convocação, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para a sua aceitação estipuladas nos incisos abaixo, no valor de R$ 1.643.850,00 (um milhão, seiscentos e quarenta e três mil e oitocentos e cinquenta reais), correspondente a 5 % (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas por este; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a)  O Instrumento de Apólice de Seguro deve prever expressamente: 1. responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas à CONTRATADA; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a)  O Instrumento de Fiança deve prever expressamente: 1. renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.      Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pela CONTRATADA durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.   Parágrafo Segundo Em caso de alteração do valor contratual, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, a CONTRATADA deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, a CONTRATADA deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe à CONTRATADA obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.  Parágrafo Quarto No caso de Consórcio, somente será aceita uma única garantia.').
contract_clause(contrato_ocs_042_2021, clausula_decima_primeira_obrigacoes_contratada, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DA CONTRATADA', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA:  I - enviar ao BNDES e manter atualizada lista com nome completo, telefone fixo e móvel, e endereço de e-mail de, pelo menos, 2 (dois) de seus empregados que poderão atuar como prepostos para participar das reuniões de acompanhamento do Contrato e também praticar atos administrativos relativos ao Contrato. II - atender prontamente a quaisquer exigências do BNDES, no que diz respeito às suas necessidades; III - prestar todos os esclarecimentos que lhe forem solicitados pelo BNDES; IV - identificar seus profissionais com crachás da empresa e informar ao BNDES os horários em que estes efetuarão serviços nas dependências do BNDES, observando todas as leis e normas regulamentadoras (NR’s) relativas à segurança  do trabalho, notadamente as que integrarem a Portaria MTE nº 3.214/78, dentre outras aplicáveis à espécie; V - adotar medidas de segurança adequadas, no âmbito das atividades sob seu controle, para a manutenção do sigilo referido no item Erro! Fonte de referência não encontrada.; VI - limitar o acesso às informações aos seus gerentes, diretores e outros profissionais que estejam desempenhando ou supervisionando os trabalhos decorrentes do contrato; VII - não usar, copiar, duplicar ou de alguma outra forma reproduzir ou reter todas ou quaisquer informações do BNDES, exceto se autorizado previamente, por escrito; VIII - não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha a ter acesso em razão do serviço; IX - garantir que as pessoas com acesso a qualquer parte das informações do BNDES estejam cientes de sua natureza sigilosa e da obrigação relacionada a este fato; X - devolver, ao final do contrato, os crachás de identificação fornecidos pelo BNDES, sob pena de indenização dos danificados ou perdidos; XI - informar ao BNDES toda e qualquer irregularidade observada; XII - manter o mais completo e absoluto sigilo sobre os dados, materiais, documentos e informações a que vier a ter acesso, direta ou indiretamente, durante a execução do objeto, dedicando especial atenção à sua guarda. A formalização deste compromisso se dará através da assinatura, por parte do representante legal da Contratada e dos profissionais envolvidos diretamente na execução do objeto, do Termo de Confidencialidade; XIII - permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do §1º do artigo 33 da Resolução CMN nº 4.557/2017, além de cumprir demais obrigações associadas a prestadores de serviços terceirizados de processamento ou armazenamento de dados de instituições financeiras vinculadas ao Banco Central do Brasil, estipuladas na Resolução CMN nº 4.658/2018 ou em normativo que vier a substitui-la. XIV - manter durante a vigência deste Contrato todas as condições de habilitação e qualificação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; XV - comunicar a imposição, a si ou a qualquer consorciada, de penalidade que acarrete o impedimento de contratar com o BNDES. XVI - reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; XVII - reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização  ou pelo acompanhamento da execução por parte do Gestor do Contrato; XVIII - pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir da CONTRATADA a comprovação de sua regularidade; XIX - providenciar, perante a Receita Federal do Brasil – RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se a CONTRATADA, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das exceções previstas no artigo 17 da Lei Complementar nº 123/2006; XX - permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; XXI - obedecer às instruções e aos procedimentos estabelecidos pelo BNDES para a adequada execução do Contrato; XXII - designar 1 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor da CONTRATADA, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XXIII - atender às solicitações do BNDES relativas à transição contratual entre a CONTRATADA e o seu sucessor na execução do serviço, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido; XXIV - garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo a CONTRATADA ser instada a intervir no processo;  XXV - responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; e XXVI - devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência do CONTRATO.') .
contract_clause(contrato_ocs_042_2021, clausula_decima_segunda_conduta_etica_contratada_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DA CONTRATADA E DO BNDES', 'A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade  administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto  A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_042_2021, clausula_decima_terceira_sigilo_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Cabe à CONTRATADA cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação do serviço:  I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no Inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação do serviço objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato; e   V. observar o disposto no Termo de Confidencialidade assinado por seus representantes legais, anexo a este Contrato.').
contract_clause(contrato_ocs_042_2021, clausula_decima_quarta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUARTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Marcelo Pinto Nascimento, que atualmente exerce a Coordenador de Serviços da ATI/DESET/GPRO, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita à CONTRATADA; IV. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VI. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_042_2021, clausula_decima_quinta_cessão_contrato_credito_sucessão_contratual_subcontratação, 'CLÁUSULA DÉCIMA QUINTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos:  I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos no Termo de Referência.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo, por conseguinte, jus ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É admitida a subcontratação da parcela do objeto deste Contrato nos termos do item 12 do Termo de Referência, condicionada à aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal operação.  Parágrafo Quarto Caso a CONTRATADA opte por subcontratar o objeto deste Contrato, permanecerá como responsável perante o BNDES pela adequada execução do ajuste, sujeitando-se, inclusive, às penalidades previstas neste Contrato, na hipótese de não cumprir as obrigações ora pactuadas, ainda que por culpa da SUBCONTRATADA.  Parágrafo Quinto Aceita, pelo BNDES, a subcontratação, a CONTRATADA deverá apresentar os Termos de Confidencialidade, conforme modelos anexos a este Contrato, assinados pelo representante legal da SUBCONTRATADA.').
contract_clause(contrato_ocs_042_2021, clausula_decima_sexta_penalidades, 'CLÁUSULA DÉCIMA SEXTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, a CONTRATADA ficará sujeita às seguintes penalidades: I. advertência; II. multa: a) de até 0,5% (zero vírgula cinco por cento), por dia de atraso, sobre o valor da primeira fatura mensal, no caso de atraso superior a 30 dias na conclusão da disponibilização do data center alternativo, descrita no item 21 do Termo de Referência e seus subitens, excetuando-se os dispostos no item 21.9; b) de até 0,25% (vinte e cinco décimos por cento), por dia de atraso, sobre o valor da primeira fatura mensal, no caso de atraso superior a 30 dias na transferência do  acervo de mídias da atual responsável pela custódia das mídias do BNDES, para as instalações da Contratada, descrita; c) de até 1% (um por cento) do valor correspondente ao recurso a ser disponibilizado por dia de atraso após os limites especificados na tabela do item 26.5.5, na entrega dos recursos com “tipo de cobrança” do tipo “CALCULADA”;  d) de até 1% (um décimo por cento) do valor mensal do recurso a ser disponibilizado por dia de atraso após os limites especificados na tabela do item 26.5.5 na implantação para os recursos em que o “tipo de cobrança” é “MENSAL”; e) de até 30% (trinta por cento) sobre o valor mensal do contrato, na hipótese de descumprimento das demais obrigações e prazos estabelecidos no contrato e não previstos nas alíneas acima.  III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades, observando-se que o valor total das multas plicadas não poderá exceder a 30% (trinta por cento) do valor global de cada Contrato.  Parágrafo Quinto A multa aplicada à CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.     Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que:  I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_042_2021, clausula_decima_setima_alterações_contratuais, 'CLÁUSULA DÉCIMA SÉTIMA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.    Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.').
contract_clause(contrato_ocs_042_2021, clausula_decima_oitava_extinção_contrato, 'CLÁUSULA DÉCIMA OITAVA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução:  I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo; IV. quando for decretada a falência da CONTRATADA; V. caso a CONTRATADA perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso a CONTRATADA seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de a CONTRATADA licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pela CONTRATADA no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução da CONTRATADA; e XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.    Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_042_2021, clausula_decima_nona_disposições_finais, 'CLÁUSULA DÉCIMA NONA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato, o Termo de Referência do Pregão Eletrônico nº 055/2020, a Proposta da CONTRATADA, a Matriz de Riscos e o Modelo de Declaração, respectivamente, Anexos I, II, III e IV ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_042_2021, clausula_vigésima_foro, 'CLÁUSULA VIGÉSIMA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Lara Godoy dos S. F. Rodrigues, advogada do BNDES, apenas para a conferência de sua redação, por autorização do representante legal que o assina.   E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via, juntamente com as testemunhas abaixo.').

% ===== END =====
